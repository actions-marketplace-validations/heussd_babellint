# Naming seems to be buggy
IMAGE?=thisisignoredforsomereason:babellint

default: buildkitd-start build buildkitd-stop

buildkitd-start:
	@-podman run -d --name buildkitd --privileged moby/buildkit:latest
	@-podman start buildkitd

buildkitd-stop:
	@-podman stop buildkitd

build:
	@buildctl \
		--addr=podman-container://buildkitd \
		build \
		--frontend dockerfile.v0 \
		--local context=. \
		--local dockerfile=. \
		--output type=oci,name=$(IMAGE) \
		| podman load


buildandrun:
	docker compose build
	
