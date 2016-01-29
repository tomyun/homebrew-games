class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160126.tar.gz"
  sha256 "9d8577822ca2d92fd5b9d519cae22eed36707b0e7491716bc6802db9778e5657"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "a5a4115642d8b041ca8fa6fec7f1e13e2f37a83c3afcc112a455561c6f8b8f7d" => :el_capitan
    sha256 "b5317ab7f0be7da5c7ab5c8eb7b97c93a1dda4ad44d401e292594b275ee6311c" => :yosemite
    sha256 "69dc6ee7874fa8a23f77a577d0ee43967c46be183c19c818d9a154287d0c4d32" => :mavericks
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
