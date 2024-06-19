ccont: Dockerfile
	docker build -t ccont .
	$(eval ID := $(shell docker create ccont 2>/dev/null))
	sleep 5
	docker cp ${ID}:/usr/src/ccont/ccont .
	docker rm ${ID}
