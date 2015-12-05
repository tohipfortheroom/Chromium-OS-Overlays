# Copyright (c) 2012 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

# NOTE: This ebuild could be overridden in an overlay to provide a
# board-specific xorg.conf as necessary.

EAPI=4
CROS_WORKON_COMMIT="307f93cab50f197a553e739174ca62bfb0f7e787"
CROS_WORKON_TREE="91ea11c39ebe0828b73f06d719b87a84e185fb82"
CROS_WORKON_PROJECT="chromiumos/platform/xorg-conf"
CROS_WORKON_OUTOFTREE_BUILD=1

inherit cros-workon user

DESCRIPTION="Board specific xorg configuration file."
HOMEPAGE="http://www.chromium.org/"
SRC_URI=""

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="X"

RDEPEND=""
DEPEND="X? ( x11-base/xorg-server )"

src_install() {
	insinto /etc/X11
	doins "${FILESDIR}/xorg.conf"

	insinto /etc/X11/xorg.conf.d
	doins 20-touchscreen.conf
}

pkg_preinst() {
	enewuser "xorg"
	enewgroup "xorg"
}
