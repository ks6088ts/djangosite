FROM python:3.6.8

ARG REPO_URL="https://github.com/ks6088ts/djangosite.git"
ARG REPO_DIR="/djangosite"

ENV PIPENV_VENV_IN_PROJECT true

RUN apt-get update -y && apt-get install -y \
    emacs \
    make \
    systemd

RUN git clone ${REPO_URL} ${REPO_DIR}

COPY .env ${REPO_DIR}/.env

RUN cd ${REPO_DIR} && \
    mkdir static && \
    make init && \
    make django
