#!/bin/bash

cd /root
if [ ! -d moos-ivp-rturrisi ]; then 
    echo "Cloning <moos-ivp-rturrisi>"
    git clone git@github.com:raymondturrisi/moos-ivp-rturrisi.git &> /dev/null
    cd moos-ivp-rturrisi && ./build.sh &> /dev/null && echo "moos-ivp-rturrisi - Build ok!" || echo "moos-ivp-rturrisi - Build Fail!"
else
    echo "Updating <moos-ivp-rturrisi>"
    cd moos-ivp-rturrisi && git pull &> /dev/null && ./build.sh &> /dev/null && echo "moos-ivp-rturrisi - Build ok!" || echo "moos-ivp-rturrisi - Build Fail!"
fi

rm -rf /root/moos-ivp-rturrisi/missions/convoy_baseline/logs
ln -s /root/dockerlogs /root/moos-ivp-rturrisi/missions/convoy_baseline/logs

cd /root
if [ ! -d moos-ivp-pavlab ]; then 
    echo "Checking out <moos-ivp-pavlab>"
    svn co svn+ssh://rturrisi@oceanai.mit.edu/home/svn/repos/moos-ivp-pavlab &> /dev/null
    cd moos-ivp-pavlab && ./ninja_build.sh &> /dev/null && echo "moos-ivp-pavlab - Build ok!" || echo "moos-ivp-pavlab - Build Fail!"
else
    echo "Updating <moos-ivp-pavlab>"
    cd moos-ivp-pavlab && svn up &> /dev/null && ./ninja_build.sh &> /dev/null && echo "moos-ivp-pavlab - Build ok!" || echo "moos-ivp-pavlab - Build Fail!"
fi

cd /root
if [ ! -d moos-ivp-swarm ]; then 
    echo "Checking out <moos-ivp-swarm>"
    svn co svn+ssh://rturrisi@oceanai.mit.edu/home/svn/repos/moos-ivp-swarm/trunk moos-ivp-swarm &> /dev/null
    cd moos-ivp-swarm && ./build.sh &> /dev/null && echo "moos-ivp-swarm - Build ok!" || echo "moos-ivp-swarm - Build Fail!"
else
    echo "Updating <moos-ivp-swarm>"
    cd moos-ivp-swarm && svn up && ./build.sh &> /dev/null && echo "moos-ivp-swarm - Build ok!" || echo "moos-ivp-swarm - Build Fail!"
fi

PATH=$PATH:/root/moos-ivp/bin
PATH=$PATH:/root/moos-ivp/scripts
PATH=$PATH:/root/moos-ivp-rturrisi/bin
PATH=$PATH:/root/moos-ivp-pavlab/bin
PATH=$PATH:/root/moos-ivp-swarm/bin
export PATH=$PATH

IVPBD=/root/moos-ivp/lib
IVPBD=$IVPBD:/root/moos-ivp/lib
IVPBD=$IVPBD:/root/moos-ivp-swarm/lib
IVPBD=$IVPBD:/root/moos-ivp-pavlab/lib
export IVP_BEHAVIOR_DIRS=$IVPBD


cd /root

echo "## A bash profile when testing and setting up the environment" >> /root/.bashrc
echo "PATH=$PATH" >> /root/.bashrc
echo "export PATH" >> /root/.bashrc
echo "IVP_BEHAVIOR_DIRS=$IVP_BEHAVIOR_DIRS" >> /root/.bashrc
echo "export IVP_BEHAVIOR_DIRS" >> /root/.bashrc

bash moos-cluster-bombs/scripts/run_blaunch_1.sh

#If you need to manually poke around the dockerfile to debug, undo this tick below, and then run the following command: 

#tail -f /dev/null #undo this comment to the left - this line holds this script open indefinitely

## Copy this command
# $ docker exec -it moos-cluster-bomb /bin/bash

# It will sign you into an interactive bash session for which you can poke around. Be aware, 
#   that by default your environment will not be setup correctly, and you'll need to source 
#   the files which are generated above (the files above are made as a backup for this very reason)