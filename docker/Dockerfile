# FROM ubuntu:jammy
FROM osrf/ros:humble-desktop-full-jammy

ARG DEBIAN_FRONTEND=noninteractive

SHELL ["/bin/bash", "-c"]

RUN apt-get -y update && apt-get -y dist-upgrade

# -------------------------------------------------------------------------------------------------------------------- #
#                                             DEFAULT DEPENDENCIES & TOOLS                                             #
# -------------------------------------------------------------------------------------------------------------------- #

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    git \
    curl \
    wget \
    build-essential \
    cmake \
    lsb-release \
    gnupg \
    gnupg2 \
    locales \
    net-tools \
    iputils-ping \
    netcat \
    software-properties-common \
    python3-dev \
    python3-pip \
    python-is-python3 \
    apt-transport-https \
    apt-utils && \
    add-apt-repository universe \
    && apt-get -y autoremove \
    && apt-get clean

# -------------------------------------------------------------------------------------------------------------------- #
#                                                  OPENGL DEPENDENCIES                                                 #
# -------------------------------------------------------------------------------------------------------------------- #

# RUN apt-get update && apt-get -y upgrade && apt-get -y install \
#     libxext-dev \
#     libx11-dev \
#     libglvnd-dev \
#     libglx-dev \
#     libgl1-mesa-dev \
#     libgl1-mesa-glx \
#     libgl1-mesa-dri \
#     libegl1-mesa-dev \
#     libgles2-mesa-dev \
#     libglu1-mesa-dev \
#     freeglut3-dev \
#     mesa-utils \
#     mesa-utils-extra \
#     && apt-get -y autoremove \
#     && apt-get clean

# -------------------------------------------------------------------------------------------------------------------- #
#                                                   ROS INSTALLATION                                                   #
# -------------------------------------------------------------------------------------------------------------------- #

RUN locale-gen en_US en_US.UTF-8 && \
    update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8

# RUN add-apt-repository universe && \
#     curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg && \
#     echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null && \
#     apt-get update && \
#     apt-get -y upgrade

ENV LANG en_US.UTF-8
ENV LC_ALL en_US.UTF-8
ENV ROS_DISTRO humble
ENV QT_X11_NO_MITSHM 1
ENV TERM xterm-256color
ENV HOME /root
ENV COLCON_WS /root/colcon_ws
ENV COLCON_SRC /root/colcon_ws/src

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    ros-${ROS_DISTRO}-desktop \
    ros-dev-tools \
    python3-rosdep \
    python3-colcon-common-extensions \
    && apt-get -y autoremove \
    && apt-get clean

# -------------------------------------------------------------------------------------------------------------------- #
#                                                     DEPENDENCIES                                                     #
# -------------------------------------------------------------------------------------------------------------------- #

RUN apt-get update && apt-get -y upgrade && apt-get -y install \
    ros-${ROS_DISTRO}-ur \
    ros-${ROS_DISTRO}-ros2-control \
    ros-${ROS_DISTRO}-ros2-controllers \
    && apt-get -y autoremove \
    && apt-get clean

RUN mkdir -p ${COLCON_SRC} && \
    cd ${COLCON_WS} 

RUN source /opt/ros/${ROS_DISTRO}/setup.bash && \
    rm -rf /etc/ros/rosdep/sources.list.d/20-default.list && \
    cd ${COLCON_WS} && \
    rosdep init && \
    rosdep update && \
    rosdep install --from-paths src -y --ignore-src && \
    colcon build --symlink-install

# -------------------------------------------------------------------------------------------------------------------- #
#                                                      FINAL SETUP                                                     #
# -------------------------------------------------------------------------------------------------------------------- #

WORKDIR ${COLCON_WS}

RUN echo "source /opt/ros/${ROS_DISTRO}/setup.bash" >> ~/.bashrc && \
    echo "source ${ROS_WS}/install/setup.bash" >> ~/.bashrc && \
    echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc && \
    echo "source /usr/share/colcon_argcomplete/hook/colcon-argcomplete.bash" >> ~/.bashrc && \
    echo "export _colcon_cd_root=/opt/ros/${ROS_DISTRO}/" >> ~/.bashrc