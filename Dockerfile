FROM alpine

LABEL maintainer="Bagas Alfiandhi <dennbagas@gmail.com>" semver-tool="https://github.com/fsaintjacques/semver-tool"

RUN apk update && apk upgrade && apk add --no-cache bash curl curl-dev jq make 

COPY src src
COPY test test
COPY Makefile Makefile

RUN make install && apk del make

ENTRYPOINT [""]