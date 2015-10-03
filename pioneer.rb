class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20150927.tar.gz"
  sha256 "b68f05dc3bb10106700108d3d61afd942daade4a1e50d1a102326a91e00488d0"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "12c19991c8d3ab5896d6fec65b7304335699605f6bb783a71eb539b130bf2771" => :el_capitan
    sha256 "787b689f20f5b1a8d7f3a71567159cf1c1c3ec98512c28af8ba3043c1455046b" => :yosemite
    sha256 "93eb2e946f3ec828aa610814d91cb1c0295d9ecfd1b5d751359413c4b67c077c" => :mavericks
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
