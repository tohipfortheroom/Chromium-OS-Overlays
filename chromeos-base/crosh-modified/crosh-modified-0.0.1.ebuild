# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=4

DESCRIPTION="Modified crosh that allows dev mode"
HOMEPAGE="http://www.chromium.org/"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~*"

src_install() {
	insinto "/usr/sbin"
	doins "${FILESDIR}/crosh"
	}
