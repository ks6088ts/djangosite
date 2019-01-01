PORT_NUMBER=8080
IP_ADDRESS=0.0.0.0
DJANGO_SETTINGS_MODULE=config.settings.local
USER_NAME=admin
EMAIL_ADDRESS=admin@example.com
STATIC_ROOT=static_root
MEDIA_ROOT=media_root
DATABASE=db.sqlite3

.PHONY: init
init:
	pip3 install pipenv
	pipenv install --dev
	git submodule update --init --recursive

.PHONY: django
django:
	pipenv run python manage.py makemigrations --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py migrate --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py collectstatic --no-input --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py createsuperuser --settings $(DJANGO_SETTINGS_MODULE) --user $(USER_NAME) --email $(EMAIL_ADDRESS)

.PHONY: server
server:
	pipenv run python manage.py runserver $(IP_ADDRESS):$(PORT_NUMBER) --settings $(DJANGO_SETTINGS_MODULE)

.PHONY: clear
clear:
	rm -rf $(STATIC_ROOT)
	rm -rf $(MEDIA_ROOT)
	rm $(DATABASE)
