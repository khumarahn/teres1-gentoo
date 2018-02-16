# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit subversion

DESCRIPTION="Script for directing audio output: speakers / headphones"
HOMEPAGE="https://github.com/OLIMEX/DIY-LAPTOP"
ESVN_REPO_URI="https://github.com/khumarahn/DIY-LAPTOP/trunk/SOFTWARE/A64-TERES/teres1-audioselect"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	dobin teres1-audioselect
	newconfd "${FILESDIR}/as.confd" teres1-audioselect
	newinitd "${FILESDIR}/as.initd" teres1-audioselect
}
