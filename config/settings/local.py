from .base import *

SECRET_KEY = '@8*#m4e^8ec-1rnzu*sit&c$9io-uo$mb#d9+k9x*j)-^4ozql'

DEBUG = True

ALLOWED_HOSTS = ["*"]

STATIC_ROOT = os.path.join(BASE_DIR, 'static_root')

MEDIA_ROOT = "/Users/ks6088ts/Dropbox/tomoca/media" # os.path.join(BASE_DIR, 'media_root')

# Email
EMAIL_PORT="dummy param"
EMAIL_HOST="dummy param"
EMAIL_HOST_USER="dummy param"
EMAIL_HOST_PASSWORD="dummy param"
EMAIL_USE_TLS="dummy param"
DEFAULT_FROM_EMAIL="dummy param"
