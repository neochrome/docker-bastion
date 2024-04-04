.PHONY: test
	
test:
	docker compose down
	docker compose run test
