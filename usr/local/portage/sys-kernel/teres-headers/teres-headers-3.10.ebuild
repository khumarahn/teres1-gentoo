# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

DESCRIPTION="Kernel headers for Teres 1 DIY laptop"
HOMEPAGE="https://github.com/OLIMEX/DIY-LAPTOP"

EGIT_REPO_URI="https://github.com/OLIMEX/DIY-LAPTOP.git"
EGIT_COMMIT="e10416c79304e478136b23271e14b708be277f6f"

KEYWORDS="~arm64"

ETYPE="headers"
H_SUPPORTEDARCH="arm64"
K_DEFCONFIG="olimex_teres1_defconfig"
K_SECURITY_UNSUPPORTED=1

inherit kernel-2
detect_version

inherit git-r3

RDEPEND="!!media-sound/alsa-headers"

S="${WORKDIR}/${P}/SOFTWARE/A64-TERES/linux-a64"

src_unpack() {
	git-r3_src_unpack
}

src_install() {
	kernel-2_src_install

	# hrm, build system sucks
	find "${ED}" '(' -name '.install' -o -name '*.cmd' ')' -delete
	find "${ED}" -depth -type d -delete 2>/dev/null
}
