# backup-volume
A simple Docker container to create an encrypted backup of a docker volume, and save it to S3.

### How it works

* Mount the volume as `/volume`.
* tar the content of the the `/volume` directory.
* Pipe it to openssl where it is encrypted using the `ENC_KEY` environment variable as a key. The codec used is aes-256-cbc with salt.
* Pipe the output to s3.

Note that since it uses pipes, no data is written to the disk and therefore it should be efficient with larges volumes.


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
