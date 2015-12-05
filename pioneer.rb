class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151130.tar.gz"
  sha256 "4dd090a2dea4655bc0726d817fc9079ed1ed18d1845be458db494d55f1949c9a"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "327d8db3e29710382d59b514803419c7325a4a049e575942837f0fa183391bb6" => :el_capitan
    sha256 "dc64c96ff0d45f032f0c4b9b145423e0d191bbc9d1be306fe3218c1ab0d734f9" => :yosemite
    sha256 "6f5f82ffa5bb8d9d6eb5c39803ee0233a2ae83289c9da47e5055a72386bbb465" => :mavericks
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
