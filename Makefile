.DEFAULT_GOAL:=build

BUILD_TAG:=neochrome/bastion:latest
MAIN_CONTAINER:=bastion
DATA_CONTAINER:=bastion-data

build:
	@docker build -t $(BUILD_TAG) .

data: build
	@docker inspect $(DATA_CONTAINER) > /dev/null \
		|| docker create --name $(DATA_CONTAINER) $(BUILD_TAG)

test: data
	@docker inspect $(MAIN_CONTAINER) > /dev/null \
		|| docker run --rm -d \
			--name $(MAIN_CONTAINER) \
			-p 2222:22 \
			--volumes-from $(DATA_CONTAINER) \
			-v "$$HOME/.ssh/id_rsa.pub:/bastion/authorized_keys:ro" $(BUILD_TAG)
	@sleep 3
	@docker logs $(MAIN_CONTAINER)
	@ssh bastion@localhost -p 2222
	@docker kill $(MAIN_CONTAINER)

clean:
	@-docker rm -f $(DATA_CONTAINER) $(MAIN_CONTAINER)
	@-docker rmi -f $(BUILD_TAG)
