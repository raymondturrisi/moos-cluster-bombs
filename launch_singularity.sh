#!/bin/bash

# Define paths and other necessary variables
MCB="/home/rturrisi/moos/moos-cluster-bombs"
SINGULARITY_IMAGE="/home/rturrisi/moos/moos-cluster-bombs/moos-cluster-bomb.sif"
SSH_DIR="/home/rturrisi/.ssh"
DOCKER_LOGS_DIR="/home/rturrisi/moos/moos-ivp-rturrisi/missions/convoy_baseline/logs"

# Launch the Singularity container

singularity exec \
    --fakeroot \
    --net \
    --hostname cluster-bomb \
    --contain \
    --writable \
    --no-home \
    --pid \
    --dns 8.8.8.8 \
    --dns 8.8.4.4 \
    --dns 1.1.1.1 \
    --bind $SINGULARITY_IMAGE/root:/root\
    --bind $MCB:/root/moos-cluster-bombs \
    --bind $SSH_DIR:/root/.ssh \
    --bind $DOCKER_LOGS_DIR:/root/dockerlogs \
    $SINGULARITY_IMAGE \
    /root/moos-cluster-bombs/scripts/entrypoint.sh
