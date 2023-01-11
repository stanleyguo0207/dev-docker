# createcontainer.ps1 -image "image_name:tag_name" -name "container" -port 9901
param(
    [string]$image = "",
    [string]$name = "",
    [int]$port = 9901
)

if ([string]::IsNullOrEmpty($image) -or [string]::IsNullOrEmpty($name)) {
    Write-Host "Usage: createcontainer.ps1 -image `"image_name:tag_name`" -name `"container`" -port 9901"
    exit -1
}

function CreateContainer($_image, $_name, $_port) {
    docker create --name `"$_name`"_dvc -v /opt/docker_home hello-world:latest
    docker create --name `"$_name`" --volumes-from `"$_name`"_dvc -p `"$_port`":22  --security-opt seccomp=unconfined --privileged=true --restart=always `"$_image`" /sbin/init
    docker start $_name
}

CreateContainer $image $name $port