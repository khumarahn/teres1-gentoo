EAPI=6

inherit git-r3 autotools

EGIT_REPO_URI="https://github.com/ssvb/xf86-video-fbturbo.git"

DESCRIPTION="Xorg DDX driver for Allwinner A10/A13/A20 and other ARM devices"
HOMEPAGE="https://github.com/ssvb/xf86-video-fbturbo"

KEYWORDS=""
IUSE=""

SLOT="0"
RDEPEND="x11-base/xorg-server"
DEPEND="${RDEPEND}
	x11-proto/fontsproto
	x11-proto/randrproto
	x11-proto/renderproto
	x11-proto/videoproto
	x11-proto/xf86driproto
	x11-proto/xproto
	x11-libs/libdrm
	x11-libs/pixman"

src_prepare() {
	eautoreconf
	default
}

src_install() {
	default
	insinto /etc/X11/xorg.conf.d
	newins xorg.conf sunxi-fbturbo.conf
}
