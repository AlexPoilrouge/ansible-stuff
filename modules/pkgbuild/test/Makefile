VARS_FILE:="variables.yaml"

SSH_ARG_PORT:=$(shell yq '.ssh_test_port' $(VARS_FILE) | tr -d '"')
SSH_ARG_ANSIBLE_USER:=$(shell yq '.ssh_test_user' $(VARS_FILE) | tr -d '"')
SSH_ARG_ANSIBLE_PASSWORD:=$(shell yq '.ssh_test_password' $(VARS_FILE) | tr -d '"')
SSH_ARG_REPO_USER:=$(shell yq '.ssh_test_repo_user' $(VARS_FILE) | tr -d '"')


DOCKER_SERVICE= docker.service

IMAGE_NAME= ansible_playbook_test
CONTAINER_NAME= apb_test




test: update_docker_base
	./test1.sh

build_docker: start_docker_service
	docker build -t $(IMAGE_NAME) \
			--build-arg "SSH_USER=$(SSH_ARG_ANSIBLE_USER)" \
			--build-arg "SSH_PASSWORD=$(SSH_ARG_ANSIBLE_PASSWORD)" \
			--build-arg "REPO_USER=$(SSH_ARG_REPO_USER)" \
			.

run_docker: start_docker_service
	docker run -d --name $(CONTAINER_NAME) \
			-p $(SSH_ARG_PORT):22 \
			$(IMAGE_NAME)

stop_container:
	if [ -n "$(shell docker ps -f "name=$(CONTAINER_NAME)" -f "status=running" -q )" ]; then \
		docker stop $(CONTAINER_NAME); \
		docker rm $(CONTAINER_NAME); \
	fi

start_docker_service:
	systemctl is-active $(DOCKER_SERVICE) || systemctl start $(DOCKER_SERVICE)

ssh_connect_docker:
	sshpass -p $(SSH_ARG_ANSIBLE_PASSWORD) ssh -o StrictHostKeyChecking=no localhost -p $(SSH_ARG_ANSIBLE_USER) -l $(SSH_ARG_ANSIBLE_USER)

update_docker_base: start_docker_service
	docker pull archlinux:latest

clean: stop_container
	rm -rf ./pkg_result/*
