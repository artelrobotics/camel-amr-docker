#!/bin/bash

set -o errexit
set -o pipefail
set -o nounset
source "/opt/ros/$ROS_DISTRO/setup.bash"
source "$ROBOT_WS/devel/setup.bash"
/bin/bash