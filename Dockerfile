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
    curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /server

RUN curl -L -o server.tar.gz \
    "https://github.com/Koberecnikos/inifnite-rails-server-test/releases/download/0.4.2/InfiniteRailsServerLinux.tar.gz" \
    && tar -xzf server.tar.gz \
    && rm server.tar.gz

RUN echo "=== STRUKTURA ===" && find . -type f | head -30

RUN find . -name "InfiniteRailsServerLinux.x86_64" -exec chmod +x {} \;

EXPOSE 7777/udp
EXPOSE 7777/tcp

CMD ["bash", "-c", "$(find /server -name 'InfiniteRailsServerLinux.x86_64') -batchmode -nographics -logFile /proc/1/fd/1"]
