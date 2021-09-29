#!/bin/bash -xe

aws s3 sync \
    --delete \
    ${LOCAL_BUILD_DIR}/ \
    ${S3_URI}

aws cloudfront create-invalidation \
    --distribution-id ${CLOUDFRONT_DISTRIBUTION_ID} \
    --paths '/*'
