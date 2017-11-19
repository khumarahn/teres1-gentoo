EAPI=6

inherit git-r3

EGIT_REPO_URI="https://github.com/linux-sunxi/libvdpau-sunxi.git"

DESCRIPTION="Experimental VDPAU for Allwinner sunxi SoCs"
HOMEPAGE="https://github.com/linux-sunxi/libvdpau-sunxi"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="x11-libs/libvdpau
	x11-libs/libcedrus
	x11-libs/pixman"
RDEPEND="${DEPEND}"
