class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151109.tar.gz"
  sha256 "d7cc343cc28b46d01cd02116875a055962c7c75ca18706d7c7723e09a0aef2ef"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "be70cdf10af9f0c1f5a9d9d07aa5edda279052e603f4ecd460626b900f0620ab" => :el_capitan
    sha256 "6ce2508d56328df0d3659b831b3bc024afedb2bdcd22f1e3f350a41c989204d5" => :yosemite
    sha256 "97cf08da335493129dc20ea7cefb6cb8eb182ba159164aebd084ee64aab25018" => :mavericks
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
