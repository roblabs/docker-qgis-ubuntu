#  How to build
#    docker build -t roblabs/qgis:ubuntu .


### FROM
# https://github.com/fcwu/docker-ubuntu-vnc-desktop
FROM dorowu/ubuntu-desktop-lxde-vnc


### LABEL
# https://docs.docker.com/engine/reference/builder/#label
# docker inspect roblabs/qgis:ubuntu | json 0 | json Config.Labels
LABEL maintainer="roblabs <https://RobLabs.com>"
LABEL version="3.14.159"
LABEL description="qgis:ubuntu"
# Usage notes
#   -p   Map port 6080 to port 80
#          open http://localhost:6080  # opens in a web browser
#   -p   Map port 5901 to port 5900
#          open vnc://localhost:5901   # opens in macOS Screen Sharing
#  * -e VNC_PASSWORD, is set as required by macOS Screen Sharing
#  * -e RESOLUTION can be adjusted, examples:
#         1920x1080
#         2048x1152   # for a Retina 4K monitor
#  * -v $(pwd)
#     local directory where `docker run` is issued, $(pwd), maps to `/data` on ubuntu
LABEL usage="docker run -p 6080:80 -p 5901:5900 -e VNC_PASSWORD=1234 -e RESOLUTION=2048x1152 -v $(pwd):/data roblabs/qgis:ubuntu"


### RUN
# https://docs.docker.com/engine/reference/builder/#run

# Install notes from
#   https://www.qgis.org/en/site/forusers/alldownloads.html#debian-ubuntu
# First install some tools you will need for this instructions:
RUN sudo apt-get install gnupg software-properties-common

# Now install the QGIS Signing Key, so QGIS software from the QGIS repo will be trusted and installed:
RUN sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 51F523511C7028C3

# Add the QGIS repo for the latest stable QGIS (3.14.x Pi).
# Note: “lsb_release -c -s” in those lines will return your distro name:
RUN sudo add-apt-repository "deb     https://qgis.org/ubuntu `lsb_release -c -s` main"

# Update your repository information to reflect also the just added QGIS one:
RUN apt-get update

# Now, install QGIS!
# Note: add ‘qgis-server’ to this line if you also want to install QGIS Server:
#   add `yes` to answer a prompt for disk usage.  Worth reading the docs on this simple tool:  `man yes`
RUN yes | sudo apt-get install qgis qgis-plugin-grass


### WORKDIR & VOLUME
# Externally accessible data is by default put in /data
# https://docs.docker.com/engine/reference/builder/#volume
# https://docs.docker.com/engine/reference/builder/#workdir
WORKDIR /data
VOLUME ["/data"]
