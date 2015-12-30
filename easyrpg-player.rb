class EasyrpgPlayer < Formula
  desc "RPG Maker 2000/2003 games interpreter"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/Player/archive/0.4.0.tar.gz"
  sha256 "e5a9f26ba6bd502844e9ccb9565af46fb4fa3f8250ba37b5ee9e298af90aef61"
  head "https://github.com/EasyRPG/Player.git"

  bottle do
    cellar :any
    sha256 "d593abf3cd8e51ff7c5543760b5bfa3a6abd399d5a45bde846a19314ac01048b" => :el_capitan
    sha256 "ff258675a7533b022b90cb662cee3e12da3cd4007f62d18ee4e3486798988675" => :yosemite
    sha256 "631284d8f58da6c0b93e2ea6d35152f19bffbda711ba015145e9be81b4c5e23e" => :mavericks
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
