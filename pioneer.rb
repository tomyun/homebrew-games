class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160106.tar.gz"
  sha256 "009e99a813136f4213f733465468e72ae0022d415a807bd1e1b69a3c6b6e412d"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "6134a71d2d21a652a6ca2512fd3f9b4a673962baaa01fe252b653a355b6461ff" => :el_capitan
    sha256 "96f8f792ac0ced619fbffe726581ae8f8a7512a2dae7824350bb2bd23bd79bea" => :yosemite
    sha256 "529b1eb698056185f7df0fbce6dd347756b1e3b2fcb9e40f0b8f25e496002e5b" => :mavericks
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
