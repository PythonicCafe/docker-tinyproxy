DATA_PATH = $(CURDIR)/data
CONTAINER_ID_PATH = $(CURDIR)/.container_id
.PHONY: build create logs restart rm start stop

build:
	docker build -t tinyproxy:latest .

create:
	mkdir -p $(DATA_PATH)
	docker run -d -p 8888:8888 -v "$(DATA_PATH):/data" tinyproxy:latest > $(CONTAINER_ID_PATH)
	@echo "Container ID saved in $(CONTAINER_ID_PATH)"

logs:
	docker logs -f $(shell cat $(CONTAINER_ID_PATH))

restart: stop start

rm:
	docker rm $(shell cat $(CONTAINER_ID_PATH))

start:
	docker start $(shell cat $(CONTAINER_ID_PATH))

stop:
	docker stop $(shell cat $(CONTAINER_ID_PATH))
