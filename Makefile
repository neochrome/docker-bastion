.DEFAULT_GOAL := build

BUILD_TAG=neochrome/bastion:latest
EXAMPLE_TAG=neochrome/bastion:example

build:
	@docker build -t $(BUILD_TAG) .

example: build
	@docker build -t $(EXAMPLE_TAG) -f Dockerfile.example .

example-run: example
	@docker run --rm -it -p 2222:22 -v $$HOME/.ssh/id_rsa.pub:/bastion/authorized_keys $(EXAMPLE_TAG)

example-test:
	@ssh bastion@localhost -p 2222 /bin/true

clean:
	@docker rmi -f $(EXAMPLE_TAG) $(BUILD_TAG)
