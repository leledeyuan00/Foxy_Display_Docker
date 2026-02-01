FROM osrf/ros:humble-desktop-full

RUN apt-get update && apt-get install -y lsb-release wget gnupg vim

# ADD ROS2 Environment Config
COPY ROS2_config /root/ROS2_config
RUN touch /root/.bashrc && \
    echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "source /root/ROS2_config/ROS2_environment.bash" >> /root/.bashrc
