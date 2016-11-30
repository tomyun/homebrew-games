class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20161129.tar.gz"
  sha256 "1c6fcc9a16da2c6d664ab88764718b94d7fdf5016bc5b4f97d7b00f8eccd9336"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "42cc140ad3221ff3a57c71e78e38f60a1714bf79dc95cbe84deb1464a0c99ac8" => :sierra
    sha256 "49dfb1dd94e2bf3f5c6eb1c6c9b3b3fcebbf549a2e937609534cf529461a46cf" => :el_capitan
    sha256 "bb47ff679989cd6ef8275b7e7d3c7abac3a5ceb998812406028fc90fed31e889" => :yosemite
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
