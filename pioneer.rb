class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151010.tar.gz"
  sha256 "72e150a617c6cfb135bd1882aeb7a83ce8f4b980d5f1b4fb05668dfbfa6d8cc7"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "4326eb6c30c63a81c6e973ae81444056521983cd9fe2db49d2a5cc6d3a68c004" => :el_capitan
    sha256 "24964a0cb3462628c06d046f59d3d9e795cdad8484ec3b566b5dd90f610dbef7" => :yosemite
    sha256 "fbce5c907ea9df41570c004e38be38776d25a5e50a16bc2d521b4256035f3103" => :mavericks
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
