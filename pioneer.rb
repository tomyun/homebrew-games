class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20161028.tar.gz"
  sha256 "d8ceefc7ec22ecdbaf2408a13c80d0368675feebff558457bef2ffc7258f4b77"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "7940e412ff6d6c9a59ae92b7d99fbfbca366421781cf0fee34e36738ad39326d" => :sierra
    sha256 "c9eb3d1d4253ce80e4d7deab57d0ed24a5374eded587cdd2ab552980db24db4e" => :el_capitan
    sha256 "2a8282cae09e07a9e4801e1bc2b524f3397960213925c25ad68707fa7b920247" => :yosemite
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
