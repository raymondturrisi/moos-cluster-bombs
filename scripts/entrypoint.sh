#!/bin/bash

cd /root

### <Fetch mission-specific repositories>
if [ ! -d moos-ivp-rturrisi ]; then 
    echo "Cloning <moos-ivp-rturrisi>"
    git clone git@github.com:raymondturrisi/moos-ivp-rturrisi.git &> /dev/null && echo "Cloned <moos-ivp-rturrisi>" || echo "Cloning <moos-ivp-rturrisi> Failed"
    cd moos-ivp-rturrisi && ./build.sh &> /dev/null && echo "moos-ivp-rturrisi - Build ok!" || echo "moos-ivp-rturrisi - Build Fail!"
    echo "Updating Python Requirements for <moos-ivp-rturrisi>"
    pip3 install -r /root/moos-ivp-rturrisi/missions/convoy_baseline/info/requirements.txt &> /dev/null && echo "Python Upgrade - Success" || echo "Python Upgrade - False"
else
    echo "Updating <moos-ivp-rturrisi>"
    cd moos-ivp-rturrisi && git pull &> /dev/null && ./build.sh &> /dev/null && echo "moos-ivp-rturrisi - Build ok!" || echo "moos-ivp-rturrisi - Build Fail!"
    echo "Updating Python Requirements for <moos-ivp-rturrisi>"
    pip3 install -r /root/moos-ivp-rturrisi/missions/convoy_baseline/info/requirements.txt  &> /dev/null && echo "Python Upgrade - Success" || echo "Python Upgrade - False"
fi

### <Configure specific log locations such that containers are writing to a collective folder>

rm -rf /root/moos-ivp-rturrisi/missions/convoy_baseline/logs
ln -s /root/dockerlogs /root/moos-ivp-rturrisi/missions/convoy_baseline/logs

### </Configure specific log locations such that containers are writing to a collective folder>

cd /root
if [ ! -d moos-ivp-pavlab ]; then 
    echo "Checking out <moos-ivp-pavlab>"
    svn co svn+ssh://rturrisi@oceanai.mit.edu/home/svn/repos/moos-ivp-pavlab &> /dev/null && echo "Cloned <moos-ivp-pavlab>" || echo "Cloning <moos-ivp-pavlab> Failed"
    cd moos-ivp-pavlab && ./build.sh &> /dev/null && echo "moos-ivp-pavlab - Build ok!" || echo "moos-ivp-pavlab - Build Fail!"
else
    echo "Updating <moos-ivp-pavlab>"
    cd moos-ivp-pavlab && svn up &> /dev/null && ./build.sh &> /dev/null && echo "moos-ivp-pavlab - Build ok!" || echo "moos-ivp-pavlab - Build Fail!"
fi

cd /root
if [ ! -d moos-ivp-swarm ]; then 
    echo "Checking out <moos-ivp-swarm>"
    svn co svn+ssh://rturrisi@oceanai.mit.edu/home/svn/repos/moos-ivp-swarm/trunk moos-ivp-swarm &> /dev/null && echo "Cloned <moos-ivp-swarm>" || echo "Cloning <moos-ivp-swarm> Failed"
    cd moos-ivp-swarm && ./build.sh &> /dev/null && echo "moos-ivp-swarm - Build ok!" || echo "moos-ivp-swarm - Build Fail!"
else
    echo "Updating <moos-ivp-swarm>"
    cd moos-ivp-swarm && svn up &> /dev/null && ./build.sh &> /dev/null && echo "moos-ivp-swarm - Build ok!" || echo "moos-ivp-swarm - Build Fail!"
fi

### </Fetch mission-specific repositories>

### <Configure the path and environment for the current shell>
PATH=$PATH:/root/moos-ivp/bin
PATH=$PATH:/root/moos-ivp/scripts
PATH=$PATH:/root/moos-ivp-rturrisi/bin
PATH=$PATH:/root/moos-ivp-rturrisi/scripts
PATH=$PATH:/root/moos-ivp-pavlab/bin
PATH=$PATH:/root/moos-ivp-pavlab/scripts
PATH=$PATH:/root/moos-ivp-swarm/bin
PATH=$PATH:/root/moos-ivp-swarm/scripts
export PATH=$PATH

IVPBD=/root/moos-ivp/lib
IVPBD=$IVPBD:/root/moos-ivp/lib
IVPBD=$IVPBD:/root/moos-ivp-swarm/lib
IVPBD=$IVPBD:/root/moos-ivp-pavlab/lib
export IVP_BEHAVIOR_DIRS=$IVPBD

### </Configure the path and environment for the current shell>

cd /root

### <Add to a .bashrc file to save these settings for debugging and future shells>
echo "## A bash profile when testing and setting up the environment" >> /root/.bashrc
echo "PATH=$PATH" >> /root/.bashrc
echo "export PATH" >> /root/.bashrc
echo "IVP_BEHAVIOR_DIRS=$IVP_BEHAVIOR_DIRS" >> /root/.bashrc
echo "export IVP_BEHAVIOR_DIRS" >> /root/.bashrc

### </Add to a .bashrc file to save these settings for debugging and future shells>

#Run the desired process
bash moos-cluster-bombs/scripts/run_blaunch_1.sh