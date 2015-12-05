# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="git://github.com/anholt"
CROS_WORKON_PROJECT="linux"
CROS_WORKON_EGIT_BRANCH="vc4-kms-v3d-rpi2"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="b8b2f50546513355fecd9ac44b2355f19a9620a8"

# This must be inherited *after* EGIT/CROS_WORKON variables defined
inherit git-2 cros-kernel2 cros-workon

DESCRIPTION="Chrome OS Kernel-raspberrypi2-kms"
KEYWORDS="arm"
KERNEL="kernel7"

DEPEND="!sys-kernel/chromeos-kernel-next
	!sys-kernel/chromeos-kernel
"
RDEPEND="${DEPEND}"

src_install() {
	cros-kernel2_src_install
#	make bcm2709-rpi-2-b.dtb

        "${FILESDIR}/mkknlimg" \
                "$(cros-workon_get_build_dir)/arch/arm/boot/zImage" \
                "${T}/dtImage"

        insinto /boot
        doins "${FILESDIR}"/{cmdline,config}.txt
        doins "${T}/dtImage"
	doins "${FILESDIR}/bcm2709-rpi-2-b.dtb"
}
