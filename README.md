## Notice
Every reboot, you need enable host for docker to use docker display.

`xhost +local:docker`

`mkdir packages`


## Build & run docker (This line would be only run once. If you run this line again the container will be reconstructed)
`docker compose up -d`

## Exec 

`docker container exec -it ros2_humble_cuda /bin/bash`

