#!/bin/sh

set -e

DEST=backup-`date +%Y-%m-%d-%H:%M`.gz.enc
echo $DEST

cd /volume

tar czf - * \
    | openssl enc -aes-256-cbc -salt -k $ENC_KEY \
    | aws s3 cp - $BUCKET/$BUCKET_DIR/$DEST
