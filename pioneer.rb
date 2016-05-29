class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160525.tar.gz"
  sha256 "9eeca58338ad24e1dd8a1c42235d6eba00e32d3453eca17d2a889ebdbebd2e59"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "3807288e86a95182ba58bac31965423871c3c5b4d2d23ca5880755a8cec18682" => :el_capitan
    sha256 "d8b1463e7d5109138984151bed092e55cd795fd3c0c15cfd9697cc6774930d9d" => :yosemite
    sha256 "7c988571048aa1501c561feb853d31704fcf767b6b090a214fada3aae2b4cb10" => :mavericks
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
    assert_equal "modelcompiler #{version}", shell_output("#{bin}/modelcompiler -v 2>&1").chomp
  end
end
