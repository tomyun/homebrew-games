class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151004.tar.gz"
  sha256 "f22f5a339bdffdad5cf03f744619db3a0c99324c4b3d2ded11c29f1233a72e36"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "96c960cb32758445d0d8aa8efb902ce1c3a108d89faf2846397a37739fab95ba" => :el_capitan
    sha256 "3ff8fc86d0760fa6112f6b29635e8e334440dd89b341e702c49b265cc8ab1658" => :yosemite
    sha256 "97c4e278940295e979c43afbd86e3576a7a4338207e0abe9916e6e431330529a" => :mavericks
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
