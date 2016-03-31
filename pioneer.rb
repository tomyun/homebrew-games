class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160316.tar.gz"
  sha256 "bb85656dc58400d130f831903892fc5b478531e0ffe7839b49ced9f2f84535ed"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "03db93365681a34f3c3e17e6f8372328b21d1a7806dc95e5255dd23af19fbb1d" => :el_capitan
    sha256 "ec77b6e6dbc3f4d98f879475551b26c54aab1536d3089bf0ba9da6c3ccb2fda0" => :yosemite
    sha256 "e1a6a470ecc3868b7ffac4c1a2129bdf1be4888dcecf403ef7ab76bd11379c8a" => :mavericks
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
