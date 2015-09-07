class EasyrpgPlayer < Formula
  desc "RPG Maker 2000/2003 games interpreter"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/Player/archive/0.3.1.tar.gz"
  sha256 "f1bd236e471066d299d2fb35727c4ec855a0944d4e0c83796096b8a27e018115"
  head "https://github.com/EasyRPG/Player.git"

  bottle do
    cellar :any
    sha256 "bbc2345e1683da9b79ccd431b70217c3f0b4c5f8985bcfce722f8ba0fbf35cc6" => :yosemite
    sha256 "536498daa39cca5a8bd39ce146882939a70990cc97876a349708326bc80712d3" => :mavericks
    sha256 "7158c974430cf17b3755140b4f6e76abb4197fc42084ee760489f3f1bb3f5c1e" => :mountain_lion
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
