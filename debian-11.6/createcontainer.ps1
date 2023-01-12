# createcontainer.ps1 -image "image_name:tag_name" -name "container" -port 9901 -user "user1"
param(
    [string]$image = "",
    [string]$name = "",
    [int]$port = 9901,
    [string]$user = ""
)

if ([string]::IsNullOrEmpty($image) -or [string]::IsNullOrEmpty($name) -or [string]::IsNullOrEmpty($user)) {
    Write-Host "Usage: createcontainer.ps1 -image `"image_name:tag_name`" -name `"container`" -port 9901 -user `"user1`""
    exit -1
}

function CreateContainer($_image, $_name, $_port, $_user) {
    docker create --name `"$_name`"_dvc -v /opt/docker_home hello-world:latest
    docker create --name `"$_name`" --volumes-from `"$_name`"_dvc -p `"$_port`":22  --security-opt seccomp=unconfined --privileged=true --restart=always `"$_image`" /sbin/init
    docker start $_name
    docker exec -it $_name /bin/bash /root/createuser.sh $_user $_port
    Write-Host "create root:root accounts for container $_image $_name port:$_port"
    Write-Host "create $_user`:$_user accounts for container $_image $_name port:$_port"
}

CreateContainer $image $name $port $user