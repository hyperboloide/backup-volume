# backup-volume
A simple Docker container to create and encrypted backup of a docker volume, and save it to S3.

### Backup a volume

```
docker run \
        --rm \
        -v ~/.aws:/aws \
        -e ENC_KEY=encryption_string \
        -e BUCKET=s3://bucket.example.com \
        -e BUCKET_DIR=volume \
        -v my-volume:/volume \
        hyperboloide/backup-volume \
        backup
```

### Restore a volume

```
docker run \
    --rm -ti \
    -v ~/.aws:/aws \
    -e ENC_KEY=encryption_string \
    -e BUCKET=s3://bucket.example.com \
    -e BUCKET_DIR=volume \
    -v my-volume:/volume \
    hyperboloide/backup-volume \
    restore
```
