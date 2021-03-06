# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit subversion

DESCRIPTION="Script for controlling caps lock and num lock on teres 1 laptop"
HOMEPAGE="https://github.com/OLIMEX/DIY-LAPTOP"
ESVN_REPO_URI="https://github.com/OLIMEX/DIY-LAPTOP/trunk/SOFTWARE/A64-TERES/teres1-ledctrl"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	default
	newconfd "${FILESDIR}/led.confd" teres1-ledctrl
	newinitd "${FILESDIR}/led.initd" teres1-ledctrl
}
