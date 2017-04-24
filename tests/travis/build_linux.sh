#!/bin/bash

set -ve
version="${1}"
srcdir="$(readlink -f "$(dirname "${0}")/../../")"
container=xiphos_test
# First, create the container
docker pull "${version}"
# Install necessary packages
distro="$(echo "${version}" | sed -e 's/:.*$//')"
tag="$(echo "${version}" | sed -e 's/^.*://')"
docker run --name "${container}" --volume "${srcdir}:/xiphos" -t -d "${version}" /bin/bash
case "${distro}" in
	fedora)
		installer="dnf install -y sword-devel \
                    gcc-c++ \
                    gtk3-devel \
                    biblesync-devel \
                    dbus-glib-devel \
                    docbook-utils \
                    GConf2-devel \
                    gettext \
                    libglade2-devel \
                    gnome-doc-utils \
                    intltool \
                    libgsf-devel \
                    libuuid-devel \
                    rarian-compat \
                    webkitgtk4-devel \
                    gtkhtml3-devel"
		;&
	centos)
		installer="$(echo "${installer}" | sed -e 's/dnf/yum/')"
		;;
	ubuntu)
		docker exec -t "${container}" apt-get update
		installer="apt-get install -y
		           libsword-dev \
				   gcc \
				   g++ \
				   libgtk-3-dev \
				   libdbus-glib-1-dev \
			       docbook-utils \
				   libgconf2-dev \
				   gettext \
				   libglade2-dev \
				   gnome-doc-utils \
                   intltool \
				   libgsf-1-dev \
                   uuid-dev \
				   rarian-compat" \
		if [ "${tag}" == "14.04" ]; then
			installer="${installer} libwebkit2gtk-3.0-dev"
		elif [ "${tag}" == "16.04" ]; then
			installer="${installer} libwebkit2gtk-4.0-dev libbiblesync-dev"
		fi
		;;
esac
docker exec -t "${container}" ${installer}
# Run the tests
docker exec -t "${container}" /xiphos/tests/build_gtk3.sh
# Remove from Docker
docker rm -f "${container}"
