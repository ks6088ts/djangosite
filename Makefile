PORT_NUMBER=8080
IP_ADDRESS=0.0.0.0

.PHONY: init
init:
	pip install pipenv
	pipenv install --dev
	git submodule update --init --recursive

.PHONY: django
django:
	pipenv run python manage.py makemigrations
	pipenv run python manage.py migrate
	pipenv run python manage.py createsuperuser --user admin

.PHONY: server
server:
	pipenv run python manage.py runserver $(IP_ADDRESS):$(PORT_NUMBER)
