param(
    [string]$image = "",
    [string]$name = "",
    [int]$port = 9901
)

if ([string]::IsNullOrEmpty($image) -or [string]::IsNullOrEmpty($name)) {
    Write-Host "Usage: createcontainer.ps1 -image `"image_name:tag_name`" -name `"container_name`" -port port"
    exit -1
}

function CreateContainer($_image, $_name, $_port) {
  docker create --name `"$_name`" -p `"$_port`":22 --security-opt seccomp=unconfined --privileged=true --restart=always `"$_image`" /sbin/init
  docker start $_name
  Write-Host "create root:root accounts for container $_image $_name port:$_port"
  Write-Host "create $_name`:$_name accounts for container $_image $_name port:$_port"
}

CreateContainer $image $name $port

# createcontainer.ps1 -image "gamemaster:1.0" -name "stanley" -port 9901
