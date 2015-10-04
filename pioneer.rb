class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151002.tar.gz"
  sha256 "9996276be963813318019d58a2996c78ce0680e57c14b3f1501d422ff3655d37"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "9680cb2f6ee8dbb72aa39c1962a4aaeb7be049c9e0690ecee3ac774861c5912e" => :el_capitan
    sha256 "2fba616c863add5cb5209b3ac4f08f30c8fedd6a817e35216d27496c1391afad" => :yosemite
    sha256 "6bbfdc7941fa1f2e94f123e085158f8ce9afbd5200f9304d3635541c388065d4" => :mavericks
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "assimp"
  depends_on "freetype"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "libsigc++"
  depends_on "libvorbis"
  depends_on "libpng"
  depends_on "lua"

  needs :cxx11

  def install
    ENV.cxx11
    ENV["PIONEER_DATA_DIR"] = "#{pkgshare}/data"
    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-version=#{version}",
                          "--with-external-liblua"
    system "make", "install"
  end

  test do
    assert_equal "#{name} #{version}", shell_output("#{bin}/pioneer -v 2>&1").chomp
  end
end
