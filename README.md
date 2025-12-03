[![Build](https://github.com/stanislavbebej-ext43345/spring-cloud-config-server-native/actions/workflows/build.yml/badge.svg)](.github/workflows/build.yml)
[![dependabot](https://img.shields.io/badge/Dependabot-enabled-brightgreen?logo=dependabot)](.github/dependabot.yml)
[![editorconfig](https://img.shields.io/badge/EditorConfig-enabled-brightgreen?logo=editorconfig)](.editorconfig)

# Spring Cloud Config Server

## Development

```bash
# cat ~/.gradle/gradle.properties
systemProp.https.proxyHost=proxy.local
systemProp.https.proxyPort=3128

# https://buildpacks.io/docs/for-app-developers/how-to/special-cases/build-on-podman/#known-issues--limitations
systemctl enable --user podman.socket
systemctl start  --user podman.socket

export CFGSRV_IMAGE="docker.io/sbebej/spring-cloud-config-server-native:4.1.7"
export DOCKER_HOST="unix://$(podman info -f "{{.Host.RemoteSocket.Path}}")"

# Build with Gradle
./gradlew bootBuildImage --imageName $CFGSRV_IMAGE

# # Build with Pack
# sudo rm -fr /var/run/docker.sock
# sudo ln -s /run/user/1000/podman/podman.sock /var/run/docker.sock
# pack build $CFGSRV_IMAGE --builder paketobuildpacks/builder-noble-java-tiny --volume "$(pwd)/bindings":/platform/bindings/gradle --env BP_SPRING_CLOUD_BINDINGS_DISABLED=true --env BPE_APPEND_JAVA_TOOL_OPTIONS="-Dspring.cloud.config.server.native.searchLocations=file:/config" --env BPE_DELIM_JAVA_TOOL_OPTIONS=" " --creation-time now

pack inspect $CFGSRV_IMAGE

podman run -it --rm -p 8888:8888 -v "$(pwd)/configServer":/config:Z --name configServer $CFGSRV_IMAGE
podman inspect configServer | jq '.[0].State.Health'
podman push $CFGSRV_IMAGE
```
