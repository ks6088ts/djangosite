FROM python:3.6.8

ARG REPO_URL="https://github.com/ks6088ts/djangosite.git"
ARG REPO_DIR="/djangosite"
ARG BRANCH="feature/SupportDocker"
WORKDIR ${REPO_DIR}

ENV PIPENV_VENV_IN_PROJECT true

RUN apt-get update -y && apt-get install -y \
        emacs \
        make \
        systemd && \
    git clone -b ${BRANCH} ${REPO_URL} ${REPO_DIR} && \
    cd ${REPO_DIR} && \
        make -f build/django.mk init
