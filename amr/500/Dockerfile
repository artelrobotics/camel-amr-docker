FROM ros-amr:noetic-camel

ARG GIT_USERNAME
ARG GIT_PASSWORD
ARG DS4=false
ENV DS4=${DS4}

WORKDIR ${ROBOT_WS}/src
RUN git clone https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/artelrobotics/camel_robot.git -b camel_500
RUN git clone https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/artelrobotics/camel_urdf.git  -b camel_500

WORKDIR ${ROBOT_WS}/src/arobotics_joystick
RUN git pull origin
RUN git checkout camel_500

WORKDIR ${ROBOT_WS}/src
RUN git clone https://github.com/artelrobotics/docking_server.git -b camel_500
RUN git clone https://github.com/kam3k/laser_line_extraction.git -b master
WORKDIR ${ROBOT_WS}
RUN rosdep update
RUN rosdep install --from-paths src --ignore-src -r -y
RUN catkin build camel_robot camel_urdf docking_server arobotics_joystick laser_line_extraction

# Install ds4drv if DS4=true
RUN if [ "$DS4" = "true" ]; then \
        echo "Enabled DualShock4 Joystick"; \
        git clone https://github.com/chrippa/ds4drv.git && \
        cd ds4drv && \
        sudo python setup.py install && \
        cd ${ROBOT_WS}/src && \
        git clone https://github.com/artelrobotics/ds4_driver.git -b camel-500 && \
        cd ${ROBOT_WS} && \
        rosdep update && \
        rosdep install --from-paths src --ignore-src -r -y && \
        apt update && apt-get install -y bluez bluetooth  && \
        catkin build ds4_driver; \
    fi

WORKDIR /
COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
COPY ./start.sh /start.sh
RUN chmod +x /start.sh
ENTRYPOINT ["/entrypoint.sh"]