FROM debian:trixie

WORKDIR /app
VOLUME /data

# Create a non-root user to run the app
RUN groupadd --gid 1000 tinyproxy \
  && useradd --home-dir /app --uid 1000 --gid 1000 tinyproxy \
  && mkdir -p /app \
  && chown -R tinyproxy:tinyproxy /app

RUN apt update \
  && apt upgrade -y \
  && apt install --no-install-recommends -y tinyproxy \
  && apt purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
  && apt clean \
  && rm -rf /var/lib/apt/lists/*

ADD run.sh /app/

USER tinyproxy
CMD ["/app/run.sh"]
