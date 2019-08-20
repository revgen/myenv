#!/usr/bin/env bash
OLDPWD=${PWD}
cd $(dirname "${0}")/..

IMAGE=rev9en/transmission
VERSION=$(grep "image.version" image/Dockerfile | cut -d"\"" -f2)

get_image_info() {
	docker images --format '{{.Repository}}:{{.Tag}} ({{.Size}})' ${IMAGE}:${VERSION}
}

info() {
	echo ">>> $1"
}

cd image
info "Build ${IMAGE}:${VERSION} docker image from ${PWD}..."
existed_image=$(get_image_info)
if [ -n "${existed_image}" ]; then
	info "Image ${existed_image} exists"
	read -n 1 -p "Do you want to update it {Y/n)? " opt; echo ""
	if [ "${opt:-"Y"}" == "Y" ] || [ "${opt}" == "y" ]; then
		info "Remove image ${IMAGE}:${VERSION}" && \
		docker rmi ${IMAGE}:${VERSION} >/dev/null && \
		info "Image ${IMAGE}:${VERSION} removed"
	else
		info "Keep existed image"
	fi
fi
docker build -t ${IMAGE} ./ && \
info "Add tag ${VERSION}" && \
docker tag ${IMAGE}:latest ${IMAGE}:${VERSION} && \
info "Build docker image complete: $(get_image_info)"
if [ $? -eq 0 ]; then
	echo ""
	read -n 1 -p "Do you want to publish this image to the docker hub {Y/n)? " opt; echo ""
	if [ "${opt:-"Y"}" == "Y" ] || [ "${opt}" == "y" ]; then
		docker login && \
		info "Publishing..." && \
		docker push ${IMAGE}:${VERSION} && \
		docker push ${IMAGE}:latest
	else
		info "Skip publishing"
	fi
else
	info "Error"
fi
cd ${OLDPWD}
