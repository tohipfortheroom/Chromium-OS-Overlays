# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=2

DESCRIPTION="Chrome OS Kernel virtual package"
HOMEPAGE="http://src.chromium.org"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="arm"
IUSE="-kernel_next -kernel_sources"

RDEPEND="
	sys-kernel/raspberrypi-kernel[kernel_sources=]
"
