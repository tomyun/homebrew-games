class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20161110.tar.gz"
  sha256 "24d86095e2080fdbc6ae849dc543dcbdf214d09d34208697d915167c80775b50"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "356faedb7b59dc31f81a51fe746a1ae2033eba145bba434e00af378ea7b30ea8" => :sierra
    sha256 "0323c716c98ff5d8a21c1322c1a01b28d727737c100843601ea034b73e3afec8" => :el_capitan
    sha256 "1393600c79fc247289660bfe6a24cbf95535d34d81619086eb435783c24c742e" => :yosemite
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

    # Remove as soon as possible
    # https://github.com/pioneerspacesim/pioneer/issues/3839
    ENV["ARFLAGS"] = "cru"

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
