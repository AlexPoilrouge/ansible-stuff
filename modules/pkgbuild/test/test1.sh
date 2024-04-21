#!/bin/bash


SCRIPT_DIR="$( dirname "$( realpath "$0" )" )"

HOSTS_INVENTORY="${SCRIPT_DIR}/test_inventory.yaml"

TESTED_PLAYBOOK="$( realpath "${SCRIPT_DIR}/create_package.playbook.yaml" )"

MODULES_PATH="$( realpath "${SCRIPT_DIR}/../library" )"

TEST_RESULT_DIR="$( realpath "${SCRIPT_DIR}/pkg_result" )"

make build_docker

make run_docker

terminate(){
    echo "Failure - Stopping test container" | cowsay -f skeleton

    make stop_container

    exit 1
}

trap 'terminate' ERR

mkdir -p "${TEST_RESULT_DIR}"

COMMAND="ansible-playbook -vvv -i \"${HOSTS_INVENTORY}\" \"${TESTED_PLAYBOOK}\" -M \"${MODULES_PATH}\""

echo -e "========\nRunning: '${COMMAND}'\n========"

sh -c "${COMMAND}"


echo "Success - Stopping test container" | cowsay -f sheep

make stop_container

exit 0
