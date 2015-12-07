# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-proto/glproto/glproto-1.4.17-r1.ebuild,v 1.3 2015/03/31 18:14:22 ulm Exp $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org GL protocol headers"
KEYWORDS="arm"
LICENSE="SGI-B-2.0"
IUSE=""

RDEPEND=">=app-eselect/eselect-opengl-1.3.0"
DEPEND=""

src_install() {
	xorg-2_src_install
}

pkg_postinst() {
	xorg-2_pkg_postinst
	eselect opengl set --ignore-missing --use-old xorg-x11
}
