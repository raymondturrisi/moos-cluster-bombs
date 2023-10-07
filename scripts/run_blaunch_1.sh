#!/bin/bash

cd /root/moos-ivp-rturrisi/missions/convoy_baseline

echo "Launching <blaunch.sh>"
#This is what you'll change from machine to machine 
./blaunch.sh --cg generators/generator_set1_configs.py \
--crange="[1..2]" \
--pg generators/generator_set1_params.py \
--nogui \
--prange="[1..2]" --k 1