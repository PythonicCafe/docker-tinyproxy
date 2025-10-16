# docker-tinyproxy

Simple Dockerfile and Makefile to run [tinyproxy](https://tinyproxy.github.io/) quickly.

Execute:

```shell
make build create logs
```

Or the original commands:

```shell
# Build
docker build -t tinyproxy:latest .

# Create
mkdir -p $(pwd)/data
docker run -d --restart unless-stopped -p 8888:8888 -v "$(pwd)/data:/data" --name myproxy tinyproxy:latest > .container_id

# logs
docker logs -f myproxy
```

If `$(pwd)/data/tinyproxy.conf` does not exist, the `run.sh` script will create a simple one, with basic HTTP auth
configured (a random password is generated and printed after the file is created -- check it on `make logs`). After
running the first time you can change the settings at `data/tinyproxy.conf` and run `make restart` to restart the
container.

You can access the proxy using `http://user:pass@<hostname>:8888/` (to get `user` and `pass`, run `grep BasicAuth
data/tinyproxy.conf`).
