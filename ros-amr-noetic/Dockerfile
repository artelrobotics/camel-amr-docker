FROM ros:noetic-robot-focal-cuda12.1

SHELL ["/bin/bash", "-c"]

# install ros perception packages
RUN apt-get update && apt-get install -y --no-install-recommends \
    ros-noetic-perception=1.5.0-1* \
    && rm -rf /var/lib/apt/lists/*

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
        git \
        curl \
        imagemagick \
        python-is-python3 \
        python3-pip \
        lsb-release \
        --no-install-recommends && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY requirements.txt .
RUN  pip install -r requirements.txt

# Install ros packages
RUN apt-get update && \
    apt-get install -y \
    ros-${ROS_DISTRO}-aruco-detect &&\
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Create catkin workspace
RUN mkdir .logs && mkdir .roslog
ENV ROBOT_WS=/robot_ws
RUN mkdir -p ${ROBOT_WS}/src
WORKDIR ${ROBOT_WS}/src


# Clone packages
# Devices packages
RUN git clone --recursive https://github.com/stereolabs/zed-ros-wrapper.git
RUN git clone https://github.com/artelrobotics/daly_bms.git
RUN git clone https://github.com/artelrobotics/roboteq_driver.git -b ros1
RUN git clone https://github.com/ros-drivers/joystick_drivers.git
RUN git clone https://github.com/artelrobotics/arobotics_joystick.git
RUN git clone https://github.com/artelrobotics/arobotics_io_module.git
RUN git clone https://github.com/SICKAG/sick_scan.git

RUN git clone https://github.com/ros-planning/navigation_msgs.git -b ros1
RUN git clone https://github.com/RobotnikAutomation/robotnik_msgs.git
RUN git clone https://github.com/RobotnikAutomation/rcomponent.git
RUN git clone https://github.com/iralabdisco/ira_laser_tools.git -b ros1-master
RUN git clone https://github.com/rst-tu-dortmund/teb_local_planner.git -b noetic-devel
RUN git clone https://github.com/ros-drivers/rosserial.git -b noetic-devel
RUN git clone https://github.com/cra-ros-pkg/robot_localization.git -b noetic-devel
RUN git clone https://github.com/RobotWebTools/tf2_web_republisher.git
RUN git clone https://github.com/fkie/multimaster_fkie.git
RUN git clone https://github.com/RobotWebTools/rosbridge_suite.git -b ros1
RUN git clone https://github.com/SteveMacenski/slam_toolbox.git -b noetic-devel
RUN git clone https://github.com/artelrobotics/navigation.git -b noetic-devel
RUN git clone https://github.com/artelrobotics/costmap_wait_clear_recovery.git
RUN git clone https://github.com/artelrobotics/costmap_total_recovery.git
RUN git clone https://github.com/artelrobotics/depthimage_to_laserscan.git
RUN git clone https://github.com/CCNYRoboticsLab/imu_tools -b noetic

# Build packages in catkin workspace
WORKDIR ${ROBOT_WS}
RUN rosdep update
RUN sudo apt-get update && rosdep install --from-paths src --ignore-src -r -y
RUN catkin init
RUN catkin config  --extend /opt/ros/${ROS_DISTRO}
RUN catkin build