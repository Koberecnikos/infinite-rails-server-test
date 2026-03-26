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

RUN curl -L -v -o server.tar.gz \
    "https://github.com/Koberecnikos/inifnite-rails-server-test/releases/download/0.4.2/InfiniteRailsServerLinux.tar.gz" \
    && echo "=== VELIKOST SOUBORU ===" \
    && ls -lh server.tar.gz \
    && echo "=== OBSAH ARCHIVU ===" \
    && tar -tzf server.tar.gz \
    && tar -xzf server.tar.gz \
    && rm server.tar.gz \
    && echo "=== SOUBORY PO ROZBALENI ===" \
    && ls -la \
    && find . -name "*.x86_64" \
    && chmod +x ./InfiniteRailsServerLinux.x86_64

EXPOSE 7777/udp
EXPOSE 7777/tcp

CMD ["./InfiniteRailsServerLinux.x86_64", "-batchmode", "-nographics", "-logFile", "/proc/1/fd/1"]
