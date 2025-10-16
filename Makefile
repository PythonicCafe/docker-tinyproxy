DATA_PATH = $(CURDIR)/data
CONTAINER_ID_PATH = $(CURDIR)/.container_id
CONTAINER_NAME = myproxy
.PHONY: build create logs restart rm start stop

build:
	docker build -t tinyproxy:latest .

create:
	mkdir -p $(DATA_PATH)
	docker run -d --restart unless-stopped -p 8888:8888 -v "$(DATA_PATH):/data" --name $(CONTAINER_NAME) tinyproxy:latest > $(CONTAINER_ID_PATH)
	@echo "Container $(CONTAINER_NAME) started. ID saved in $(CONTAINER_ID_PATH)"

logs:
	docker logs -f $(CONTAINER_NAME)

restart: stop start

rm:
	docker rm $(CONTAINER_NAME)

start:
	docker start $(CONTAINER_NAME)

stop:
	docker stop $(CONTAINER_NAME)
