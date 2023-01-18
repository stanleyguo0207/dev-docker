# createcontainer.ps1 -image dev_debian:11.6 -name stanley -port 9901
param(
    [string]$image = "",
    [string]$name = "",
    [int]$port = 9901
)

if ([string]::IsNullOrEmpty($image) -or [string]::IsNullOrEmpty($name)) {
    Write-Host "Usage: createcontainer.ps1 -image `"image_name:tag_name`" -name `"container_name`" -port port"
    exit -1
}

$ScriptDir = Get-Location
$ToolsDir = "$ScriptDir\..\tools"

function CreateContainer($_image, $_name, $_port) {
    docker create --name `"$_name`"_dvc -v /opt/docker_home hello-world:latest
    docker create --name `"$_name`" --volumes-from `"$_name`"_dvc -p `"$_port`":22  --security-opt seccomp=unconfined --privileged=true --restart=always `"$_image`" /sbin/init
    docker start $_name
    docker cp $ScriptDir\createuser.sh ${_name}:/root
    docker cp $ScriptDir\init.sh ${_name}:/opt/docker_home
    docker cp $ToolsDir\gdbinit.tar.gz ${_name}:/opt/docker_home
    docker exec -it $_name /bin/bash /root/createuser.sh $_name $_port
    Write-Host "create root:root accounts for container $_image $_name port:$_port"
    Write-Host "create $_name`:$_name accounts for container $_image $_name port:$_port"
}

CreateContainer $image $name $port