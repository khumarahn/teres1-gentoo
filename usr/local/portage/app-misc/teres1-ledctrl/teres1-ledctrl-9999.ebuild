# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Script for controlling caps lock and num lock on teres 1 laptop"
HOMEPAGE="https://github.com/OLIMEX/DIY-LAPTOP"
EGIT_REPO_URI="https://github.com/OLIMEX/DIY-LAPTOP.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/SOFTWARE/A64-TERES/teres1-ledctrl"

src_install() {
	default
	newconfd "${FILESDIR}/led.confd" teres1-ledctrl
	newinitd "${FILESDIR}/led.initd" teres1-ledctrl
}
