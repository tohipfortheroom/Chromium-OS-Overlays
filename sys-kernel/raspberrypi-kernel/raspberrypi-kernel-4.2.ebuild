# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

CROS_WORKON_REPO="https://github.com/haggster66"
CROS_WORKON_PROJECT="linux"
CROS_WORKON_EGIT_BRANCH="master"
CROS_WORKON_BLACKLIST="1"
CROS_WORKON_COMMIT="1eb9d7a52e133e1865f26098af724f9c9c016c68"

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
	"${D}/../work/raspberrypi-kernel/scripts/mkknlimg" \
                "$(cros-workon_get_build_dir)/arch/arm/boot/zImage" \
                "${T}/kernel.img"

	insinto /firmware/rpi
	doins "${FILESDIR}"/{cmdline,config}.txt
	doins "${T}/kernel.img"
	doins "$(cros-workon_get_build_dir)/arch/arm/boot/dts/bcm2709-rpi-2-b.dtb"
	doins -r "$(cros-workon_get_build_dir)/arch/arm/boot/dts/overlays"
}
