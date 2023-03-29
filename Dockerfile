FROM osrf/ros:humble-desktop-full as base

RUN apt-get update && apt-get install -y gnupg2 curl wget
RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.0-1_all.deb
RUN sudo dpkg -i cuda-keyring_1.0-1_all.deb

ENV NV_CUDA_LIB_VERSION 12.1.0-1

FROM base as base-amd64

ENV NV_NVTX_VERSION 12.1.66-1
ENV NV_LIBNPP_VERSION 12.0.2.50-1
ENV NV_LIBNPP_PACKAGE libnpp-12-1=${NV_LIBNPP_VERSION}
ENV NV_LIBCUSPARSE_VERSION 12.0.2.55-1

ENV NV_LIBCUBLAS_PACKAGE_NAME libcublas-12-1
ENV NV_LIBCUBLAS_VERSION 12.1.0.26-1
ENV NV_LIBCUBLAS_PACKAGE ${NV_LIBCUBLAS_PACKAGE_NAME}=${NV_LIBCUBLAS_VERSION}

ENV NV_LIBNCCL_PACKAGE_NAME libnccl2
ENV NV_LIBNCCL_PACKAGE_VERSION 2.17.1-1
ENV NCCL_VERSION 2.17.1-1
ENV NV_LIBNCCL_PACKAGE ${NV_LIBNCCL_PACKAGE_NAME}=${NV_LIBNCCL_PACKAGE_VERSION}+cuda12.1

FROM base-amd64

ARG TARGETARCH

LABEL maintainer "NVIDIA CORPORATION <cudatools@nvidia.com>"

RUN apt-get update && apt-get install -y --no-install-recommends \
    cuda-libraries-12-1=${NV_CUDA_LIB_VERSION} \
    ${NV_LIBNPP_PACKAGE} \
    cuda-nvtx-12-1=${NV_NVTX_VERSION} \
    libcusparse-12-1=${NV_LIBCUSPARSE_VERSION} \
    ${NV_LIBCUBLAS_PACKAGE} \
    ${NV_LIBNCCL_PACKAGE} \
    && rm -rf /var/lib/apt/lists/*

# Keep apt from auto upgrading the cublas and nccl packages. See https://gitlab.com/nvidia/container-images/cuda/-/issues/88
RUN apt-mark hold ${NV_LIBCUBLAS_PACKAGE_NAME} ${NV_LIBNCCL_PACKAGE_NAME}

# Add entrypoint items
ENV NVIDIA_PRODUCT_NAME="CUDA"

# ADD ROS2 Environment Config
COPY ROS2_config /root/ROS2_config
RUN touch /root/.bashrc && \
    echo "source /opt/ros/humble/setup.bash" >> /root/.bashrc && \
    echo "source /root/ROS2_config/ROS2_environment.bash" >> /root/.bashrc
