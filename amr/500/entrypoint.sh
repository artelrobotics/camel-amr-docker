#!/bin/bash
set -e

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "$ROBOT_WS/devel/setup.bash"
# Get the IP address and hostname
IP4=$(hostname -i)
HOSTNAME=$(hostname)

# Set ROS environment variables
export IP4
export HOSTNAME
export ROS_IP=$IP4
export ROS_MASTER_URI=http://$ROS_IP:11311/
export ROS_HOSTNAME=$HOSTNAME
export ROS_LOG_DIR=/.roslog/
export ROBOT_NAME=$(echo ${HOSTNAME} | tr "-" "_")
export ROS_PACKAGE_PATH=$ROBOT_WS/src:/opt/ros/$ROS_DISTRO/share
export ROS_NAMESPACE=$ROBOT_NAME
export ROS_PARALLEL_JOBS='-j12 -l12'

echo " "
echo "Ubuntu version: $(lsb_release -ds)"
echo "ROS version: $ROS_DISTRO"
echo "IPv4 = $(hostname -i)"
echo "HOSTNAME = $(hostname)"
echo "ROBOT_NAME = $ROBOT_NAME"
echo "ROS_MASTER_URI = $ROS_MASTER_URI"
echo " "
exec "$@"