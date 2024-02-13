FROM node:18.12-bullseye-slim

# Discussion for the reason of this line can be found here https://github.com/bazelbuild/rules_closure/issues/351
ENV OPENSSL_CONF=/dev/null
# OpenSSL upgrade section

RUN apt-get update -qq && \
    apt-get install -qy \ 
    ca-certificates \
    bzip2 \
    curl \
    libfontconfig \
    --no-install-recommends

RUN yarn global add phantomjs-prebuilt
ADD . /app
WORKDIR /app
CMD ./tests.sh
