PORT_NUMBER=8080
IP_ADDRESS=0.0.0.0
DJANGO_SETTINGS_MODULE=config.settings.local
USER_NAME=admin
EMAIL_ADDRESS=admin@example.com

.PHONY: init
init:
	pip install pipenv
	pipenv install --dev
	git submodule update --init --recursive

.PHONY: django
django:
	pipenv run python manage.py makemigrations --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py migrate --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py collectstatic --settings $(DJANGO_SETTINGS_MODULE)
	pipenv run python manage.py createsuperuser --settings $(DJANGO_SETTINGS_MODULE) --user $(USER_NAME) --email $(EMAIL_ADDRESS)

.PHONY: server
server:
	pipenv run python manage.py runserver $(IP_ADDRESS):$(PORT_NUMBER) --settings $(DJANGO_SETTINGS_MODULE)
