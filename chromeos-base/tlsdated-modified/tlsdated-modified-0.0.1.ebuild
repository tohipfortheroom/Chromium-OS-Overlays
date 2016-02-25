# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Modified tlsdated.conf in order to prevent tlsdated from respawning too fast"
HOMEPAGE="http://www.chromium.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~*"

src_install() {
	insinto "/etc/init"
	doins "${FILESDIR}/tlsdated.conf"
	}
