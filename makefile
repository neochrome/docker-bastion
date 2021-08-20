.PHONY: test
	
test:
	docker-compose up \
		--force-recreate \
		--build \
		--renew-anon-volumes \
		--exit-code-from test
