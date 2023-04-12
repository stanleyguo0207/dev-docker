param(
    [string]$image = "",
    [string]$name = "",
    [int]$port = 9901,
    [string]$host_port_range = ""
)

if ([string]::IsNullOrEmpty($image) -or [string]::IsNullOrEmpty($name)) {
    Write-Host "Usage: createcontainer.ps1 -image `"image_name:tag_name`" -name `"container_name`" -port port"
    exit -1
}

if ([string]::IsNullOrEmpty($host_port_range)) {
    $port_range = ""
}
else {
    $container_port_start = 19900
    $container_port_max = 21

    $host_port_array = $host_port_range -split "-"
    if (2 -ne $host_port_array.Length) {
        Write-Host "Error: the range must be two numbers, host $host_port_array"
        exit -1
    }
    $host_port_start = $host_port_array[0] -as [int]
    $host_port_max = ($host_port_array[1] -as [int]) - $host_port_start + 1
    if ($host_port_max -gt $container_port_max) {
        Write-Host "Error: only supports opening up to 20 ports, host $host_port_range"
        exit -1
    }

    $port_range = ""
    for ($i = 0; $i -lt $host_port_max; $i++) {
        $tmp_host_port = $host_port_start + $i
        $tmp_container_port = $container_port_start + $i
        $port_range += "-p $tmp_host_port`:$tmp_container_port "
    }
}

$script_dir = Get-Location
$tools_dir = "$script_dir\..\tools"

function CreateContainer($_image, $_name, $_port, $_port_range) {
    docker create --name `"$_name`"_dvc -v /opt/docker_home hello-world:latest
    docker create --name `"$_name`" --volumes-from `"$_name`"_dvc -p `"$_port`":22 $_port_range.Split() --security-opt seccomp=unconfined --privileged=true --restart=always `"$_image`" /sbin/init
    docker start $_name
    docker cp $script_dir\createuser.sh ${_name}:/root
    docker cp $tools_dir ${_name}:/opt/docker_home
    docker exec -it $_name /bin/bash /root/createuser.sh $_name $_port
    Write-Host "create root:root accounts for container $_image $_name port:$_port"
    Write-Host "create $_name`:$_name accounts for container $_image $_name port:$_port"
}

CreateContainer $image $name $port $port_range

# createcontainer.ps1 -image "gamemaster:1.0" -name "stanley" -port 9901 -host_port_range "19900-19905"
