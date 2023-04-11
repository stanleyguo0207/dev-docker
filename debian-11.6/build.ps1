param(
    [string]$image = ""
)

if ([string]::IsNullOrEmpty($image)) {
    Write-Host "Usage: build.ps1 -image `"image_name:tag_name`""
    exit -1
}

docker login
docker pull hello-world:latest
docker pull debian:11.6
docker build --network=host --no-cache -f Dockerfile -t $image .

# build.ps1 -image "dev_debian:v11.6"
