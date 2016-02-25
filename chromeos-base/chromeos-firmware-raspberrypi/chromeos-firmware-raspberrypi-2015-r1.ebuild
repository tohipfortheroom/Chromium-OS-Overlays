# Copyright (c) 2013 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Chrome OS Firmware"
HOMEPAGE="http://www.chromium.org/"
LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="arm"
IUSE=""
RESTRICT="mirror"

S=${WORKDIR}

FW_REV="master"
SRC_URI="https://github.com/raspberrypi/firmware/archive/${FW_REV}.zip -> ${P}.zip"

src_install() {
	cd "firmware-master/boot"
	insinto /firmware/rpi
	doins fixup.dat start.elf bootcode.bin
	doins -r overlays
}
