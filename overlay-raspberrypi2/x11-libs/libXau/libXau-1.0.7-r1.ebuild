# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libXau/Attic/libXau-1.0.7-r1.ebuild,v 1.4 2015/04/13 00:07:48 mrueg dead $

EAPI=5

XORG_MULTILIB=yes
inherit xorg-2

DESCRIPTION="X.Org X authorization library"

KEYWORDS="arm"
IUSE=""

RDEPEND=">=x11-proto/xproto-7.0.24[${MULTILIB_USEDEP}]"
DEPEND="${RDEPEND}"
