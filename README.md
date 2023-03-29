## Notice
Every reboot, you need enable host for docker to use docker display.

`xhost +local:docker`

## Configure the apt source for nvidia docker container.
``` bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
  && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | sudo gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
  && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
        sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
        sudo tee /etc/apt/sources.list.d/nvidia-container-toolkit.list
```

`sudo apt-get update`

`sudo apt-get install nvidia-container-toolkit`

`sudo systemctl restart docker`

`mkdir packages`


## Build & run docker
`docker compose up -d`

## Exec 

`docker container exec -it ros2_foxy_cuda /bin/bash`

