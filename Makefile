# Naming seems to be buggy
IMAGE?=thisisignoredforsomereason:babellint

default: buildkitd-start build

buildkitd-start:
	@-docker run -d --name buildkitd --privileged moby/buildkit:latest
	@-docker start buildkitd

buildkitd-stop:
	@-docker stop buildkitd

build:
	@buildctl \
		--addr=podman-container://buildkitd \
		build \
		--frontend dockerfile.v0 \
		--local context=. \
		--progress=plain \
		--local dockerfile=. \
		--output type=oci,name=$(IMAGE) \
		| podman load

		#--addr=tcp://$(shell multipass info podman --format json | jq -r ".info.podman.ipv4[]"):1234 \

buildandrun:
	docker-compose build
	
