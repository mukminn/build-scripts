#!/bin/bash -xe

aws s3 sync \
    --delete \
    ${DIST_DIR}/ \
    ${S3_URI}

aws cloudfront create-invalidation \
    --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} \
    --paths '/*'
