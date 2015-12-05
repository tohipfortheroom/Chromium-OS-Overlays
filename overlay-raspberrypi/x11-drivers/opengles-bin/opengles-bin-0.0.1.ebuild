# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

inherit cros-binary

DESCRIPTION="Binary OpenGL|ES libraries for Raspberry Pi"
SLOT="0"
KEYWORDS="arm"
IUSE="hardfp"

DEPEND=""
RDEPEND="x11-drivers/opengles-headers
	!x11-drivers/opengles"

S=${WORKDIR}

src_unpack() {
        if use hardfp; then
		CROS_BINARY_URI="http://distribution.hexxeh.net/distfiles/raspberrypi-opengles-bin-hardfp-0.0.1.tbz2"
		CROS_BINARY_SUM="78dd05358746f5137c572b63417bfc30c24a0875"
	else
		CROS_BINARY_URI="http://distribution.hexxeh.net/distfiles/raspberrypi-opengles-bin-softfp-0.0.1.tbz2"
		CROS_BINARY_SUM="68e6e063e45700913eaebb1afec24fa4a5e0cf6a"
	fi

        cros-binary_src_unpack

        local pkg=${CROS_BINARY_URI##*/}
        ln -s "${CROS_BINARY_STORE_DIR}/${pkg}"
        unpack ./${pkg}
}

src_install() {
	newlib.so libEGL.so libEGL.so.1
	dosym libEGL.so.1 /usr/lib/libEGL.so

	newlib.so libGLESv2.so libGLESv2.so.2
	dosym libGLESv2.so.2 /usr/lib/libGLESv2.so

	dolib.so libbcm_host.so libvchiq_arm.so libvcos.so
}
