class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160504.tar.gz"
  sha256 "b8e2dd8a6275a75bbd9587e624ccc538154718ac889c9eb9d7d6e81d41f47bc0"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "d08ec687c2f12be52f88728326260bd30d72b1be89634528e5a704996706e8c2" => :el_capitan
    sha256 "85fbda1900353e6a9418617c76812b96c9e32828b3337f4a40c2141e0129d523" => :yosemite
    sha256 "f179057ad65437314f20cac081cdb3d30ccf51a49d99b53a26e78d48fb1e1fc0" => :mavericks
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
