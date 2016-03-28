FROM python:2-alpine

ENV AWS_CONFIG_FILE=/aws/config
ENV AWS_SHARED_CREDENTIALS_FILE=/aws/credentials
ENV AWS_DEFAULT_REGION=eu-central-1

ENV BUCKET=s3://the_bucket
ENV BUCKET_DIR=/volume

WORKDIR /usr/local/bin
COPY backup.sh      backup
COPY restore.sh     restore
RUN  chmod 555 backup restore

RUN apk --update upgrade \
    && apk add curl openssl \
    && rm -rf /var/cache/apk/*

WORKDIR /tmp
RUN curl "https://s3.amazonaws.com/aws-cli/awscli-bundle.zip" -o "awscli-bundle.zip" \
    && unzip awscli-bundle.zip \
    && ./awscli-bundle/install -i /usr/local/aws -b /usr/local/bin/aws \
    && rm -fr /var/lib/apt/lists/* /tmp/* /var/tmp/*
