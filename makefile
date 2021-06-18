.PHONY: test
	
test:
	docker-compose up --force-recreate --build --exit-code-from test
