#!/bin/bash

xhost +local:root
docker run --rm \
       --gpus all \
       --privileged \
       --volume="/dev:/dev" \
       --name "kinect" \
       --net=host \
       --env="DISPLAY" \
       --env="QT_X11_NO_MITSHM=1" \
       --env="ROS_IP" \
       --env="ROS_MASTER_URI" \
       --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
       -it iory/docker-ros-k4a:latest bash -c "source /catkin_ws/devel/setup.bash && roslaunch /kinectdriver_nodelet.launch camera:=${1:k4a} body_tracking_enabled:=true depth_mode:=WFOV_2X2BINNED color_resolution:=720P fps:=30 point_cloud:=false rgb_point_cloud:=false publish_tf:=true use_republish:=false use_depth_registration:=false tf_prefix:=azure_"
xhost +local:docker
