class EasyrpgPlayer < Formula
  desc "RPG Maker 2000/2003 games interpreter"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/Player/archive/0.4.0.tar.gz"
  sha256 "e5a9f26ba6bd502844e9ccb9565af46fb4fa3f8250ba37b5ee9e298af90aef61"
  head "https://github.com/EasyRPG/Player.git"

  bottle do
    cellar :any
    sha256 "4e1171a4476ae9f794ba527bbd7b8fc33c65b32af2e44dda5148e1beb0c750a1" => :el_capitan
    sha256 "2b5f3050949289bb24efcc878c27c2e691e3e14e88cb501a8ad237f9a741ddfd" => :yosemite
    sha256 "44f3488b66b12ef5243c17465fd6e995d0d277443d4c066e6ba41be6923da047" => :mavericks
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
