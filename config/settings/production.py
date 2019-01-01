from .base import *

SECRET_KEY = ''

DEBUG = False

ALLOWED_HOSTS = []

STATIC_ROOT = '/var/www/{}/static'.format(PROJECT_NAME)

MEDIA_ROOT = '/var/www/{}/media'.format(PROJECT_NAME)
