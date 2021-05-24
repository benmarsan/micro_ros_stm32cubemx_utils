#!/bin/bash

# Runs all the microros static_library_builder steps that require internet access.

######## Init ########

apt update
apt install -y gcc-arm-none-eabi

cd /uros_ws

source /opt/ros/$ROS_DISTRO/setup.bash
source install/local_setup.bash

ros2 run micro_ros_setup create_firmware_ws.sh generate_lib

######## Adding extra packages ########
pushd firmware/mcu_ws > /dev/null

    # Workaround: Copy just tf2_msgs
    git clone -b foxy https://github.com/ros2/geometry2
    cp -R geometry2/tf2_msgs ros2/tf2_msgs
    rm -rf geometry2

    # Import user defined packages
    mkdir extra_packages
    pushd extra_packages > /dev/null
        cp -R $BASE_PATH/library_generation/extra_packages/* .
        vcs import --input extra_packages.repos
    popd > /dev/null

popd > /dev/null

# Clean package cache so it's not stored in the container
apt clean
