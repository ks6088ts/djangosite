PORT_NUMBER=8080
IP_ADDRESS=0.0.0.0
DJANGO_SETTINGS_MODULE=config.settings.local
USER_NAME=admin
EMAIL_ADDRESS=admin@example.com
STATIC_ROOT=static_root
MEDIA_ROOT=media_root
DATABASE=db.sqlite3
APP_DIR=products
DATA_FILE=products.json
MODEL=products

.PHONY: init
init:
	pip install pipenv
	pipenv install --dev
	git submodule update --init --recursive

.PHONY: build
build:
	pipenv run python manage.py makemigrations --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py migrate --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py collectstatic --no-input --settings $(DJANGO_SETTINGS_MODULE)

.PHONY: load
load:
	pipenv run python manage.py loaddata $(DATA_FILE) --settings $(DJANGO_SETTINGS_MODULE)

.PHONY: dump
dump:
	pipenv run python manage.py dumpdata $(MODEL) \
		--format=json --indent=2 \
		--settings $(DJANGO_SETTINGS_MODULE) > $(DATA_FILE)

.PHONY: admin
admin:
	pipenv run python manage.py createsuperuser --settings $(DJANGO_SETTINGS_MODULE) --user $(USER_NAME) --email $(EMAIL_ADDRESS)

.PHONY: server
server:
	pipenv run python manage.py runserver $(IP_ADDRESS):$(PORT_NUMBER) --settings $(DJANGO_SETTINGS_MODULE)

.PHONY: gunicorn
gunicorn:
	pipenv run gunicorn --bind=$(IP_ADDRESS):$(PORT_NUMBER) config.wsgi:application --env DJANGO_SETTINGS_MODULE=$(DJANGO_SETTINGS_MODULE)

.PHONY: clean
clean:
	rm -rf $(STATIC_ROOT)
	rm -rf $(MEDIA_ROOT)
	rm $(DATABASE)

.PHONY: lint
lint:
	pipenv run flake8 $(APP_DIR)

.PHONY: fix
fix:
	pipenv run autopep8 -ivr $(APP_DIR)

.PHONY: test
test: lint
	# Add tests

.PHONY: deploy
deploy:
	make -f build/django.mk build DJANGO_SETTINGS_MODULE=$(DJANGO_SETTINGS_MODULE) && \
	make -f build/django.mk load DATA_FILE=/volumes/products.json DJANGO_SETTINGS_MODULE=$(DJANGO_SETTINGS_MODULE) && \
	make -f build/django.mk gunicorn DJANGO_SETTINGS_MODULE=$(DJANGO_SETTINGS_MODULE)
