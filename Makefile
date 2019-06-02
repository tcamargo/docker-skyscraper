DOCKER_USER:=tcamargo
DOCKER_ORGANIZATION=discworld
DOCKER_IMAGE:=skyscraper

docker-image:
	docker build -t $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE) .

docker-image-test: docker-image
	docker run --rm $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE) sh -c "Skyscraper -v"

docker-push:
	docker login -u $(DOCKER_USER)
	docker push $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE)

container:
	docker run --rm -it $(DOCKER_ORGANIZATION)/$(DOCKER_IMAGE)

.PHONY: docker-image docker-image-test docker-push container
