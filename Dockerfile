FROM ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    libgcc-s1 \
    libstdc++6 \
    libsdl2-2.0-0 \
    libglib2.0-0 \
    libc6 \
    libssl3 \
    ca-certificates \
    wget \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /server

# Verbose wget aby videl co se deje
RUN wget -v -O server.tar.gz \
    "https://github.com/Koberecnikos/inifnite-rails-server-test/releases/latest/download/InfiniteRailsServerLinux.tar.gz" \
    || (echo "=== WGET SELHAL ===" && exit 1)

RUN tar -tzf server.tar.gz && \
    tar -xzf server.tar.gz --strip-components=1 && \
    rm server.tar.gz && \
    ls -la && \
    chmod +x ./InfiniteRailsServerLinux.x86_64

EXPOSE 7777/udp
EXPOSE 7777/tcp

CMD ["./InfiniteRailsServerLinux.x86_64", "-batchmode", "-nographics", "-logFile", "/proc/1/fd/1"]
