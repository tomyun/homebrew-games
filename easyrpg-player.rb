class EasyrpgPlayer < Formula
  desc "RPG Maker 2000/2003 games interpreter"
  homepage "https://easyrpg.org/"
  url "https://github.com/EasyRPG/Player/archive/0.5.0.tar.gz"
  sha256 "5cf8cf5c4383b2b9c28c8dbbf15ccef601b1c66af30f783c41b98c06a8a61977"
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
  depends_on "freetype"
  depends_on "harfbuzz"
  depends_on "liblcf"
  depends_on "libpng"
  depends_on "libsndfile"
  depends_on "libvorbis"
  depends_on "libxmp"
  depends_on "mpg123"
  depends_on "pixman"
  depends_on "sdl2"
  depends_on "sdl2_mixer" => "with-libvorbis"
  depends_on "speex"

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
