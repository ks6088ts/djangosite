from .base import *
import environ

ENV_FILE = os.path.join(BASE_DIR, '.env') 

env = environ.Env()
env.read_env(ENV_FILE)

SECRET_KEY = '@8*#m4e^8ec-1rnzu*sit&c$9io-uo$mb#d9+k9x*j)-^4ozql'

DEBUG = False

ALLOWED_HOSTS = env.list('ALLOWED_HOSTS')

STATIC_ROOT = "/volumes/static"

MEDIA_ROOT = "/volumes/media"

# Email
EMAIL_PORT=env('EMAIL_PORT')
EMAIL_HOST=env('EMAIL_HOST')
EMAIL_HOST_USER=env('EMAIL_HOST_USER')
EMAIL_HOST_PASSWORD=env('EMAIL_HOST_PASSWORD')
EMAIL_USE_TLS=env('EMAIL_USE_TLS')
DEFAULT_FROM_EMAIL=env('DEFAULT_FROM_EMAIL')
