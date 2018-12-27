FROM alpine

LABEL maintainer="Shin FENG <shin.f.kan@gmail.com>"

RUN set -x \
    # Install dependencies
    && apk add --no-cache gcc g++ make \
    # Download latest live555 from official website
    && wget -qP ~ http://www.live555.com/liveMedia/public/live555-latest.tar.gz \
    && cd ~ \
    # Extract installation package
    && tar -zxf live555-latest.tar.gz \
    # Remove installation package
    && rm live555-latest.tar.gz \
    && cd live \
    # Generate makefile
    && ./genMakefiles linux \
    # Build live555 from sources
    && make \
    # Install live555
    && make install \
    && cd ~ \
    # Cleanup
    && rm -fr live

WORKDIR /data

EXPOSE 80 554

ENTRYPOINT ["live555MediaServer"]