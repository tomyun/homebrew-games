class EasyrpgPlayer < Formula
  desc "RPG Maker 2000/2003 games interpreter"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/Player/archive/0.4.1.tar.gz"
  sha256 "04f5c91ec083425bef778380f42d691f2edaa5e5a694623e4a3f21e754e6b932"
  head "https://github.com/EasyRPG/Player.git"

  bottle do
    cellar :any
    sha256 "4c857998ee14f0a85b51faabd223b4a0ba01bf79f88f3c614dfe52feea6ab63f" => :el_capitan
    sha256 "a1c91bbe2908fb05eadf1f42d00edbd557c14de2139c78f25119c47dad556641" => :yosemite
    sha256 "d60cb90d48e337c306c5958673f907260cff9e78727e8c598f97edeb50632e2a" => :mavericks
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "boost" => :build
  depends_on "liblcf"
  depends_on "libpng"
  depends_on "freetype"
  depends_on "pixman"
  depends_on "sdl2"
  depends_on "sdl2_mixer" => "with-libvorbis"

  def install
    system "autoreconf", "-i"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /EasyRPG Player #{version}$/, shell_output("#{bin}/easyrpg-player -v")
  end
end
