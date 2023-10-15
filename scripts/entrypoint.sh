#!/bin/bash

#-------------------------------------------------------------- 
#   Script: entrypoint.sh     
#   Author: Raymond Turrisi
#   LastEd: Oct. 2023
#   Desc: Entrypoint script for container cluster simulations 
#           using docker or singularity
#-------------------------------------------------------------- 

### << Ran inside of container (Docker or Singularity) >>

#Get to the working directory
cd /root

# Setup the container with a script unique to your mission needs
./moos-cluster-bombs/scripts/setup_container.sh
source /root/.bashrc
#Run the desired process
bash moos-cluster-bombs/scripts/run_blaunch_1.sh