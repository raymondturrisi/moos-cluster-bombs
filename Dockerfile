FROM raymondturrisi/focal-fossa-it

ENV DEBIAN_FRONTEND=noninteractive

WORKDIR /root

COPY scripts/ scripts/

RUN apt update -y && apt upgrade -y

RUN apt install subversion git g++ cmake python3 python3-pip libfltk1.3-dev  freeglut3-dev  libpng-dev  libjpeg-dev libxft-dev  libxinerama-dev   libtiff5-dev xterm -y

RUN svn co https://oceanai.mit.edu/svn/moos-ivp-aro/trunk/ moos-ivp && cd moos-ivp && ./build.sh && cd ..