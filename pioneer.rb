class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160316.tar.gz"
  sha256 "bb85656dc58400d130f831903892fc5b478531e0ffe7839b49ced9f2f84535ed"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "cbf993d63dfc8926176166d2c1066c1ee1cfd6f9275d4bc07836d2b9d4ac3430" => :el_capitan
    sha256 "676401dfda9d0bb1f42e7cbdb6e6083f318f171034658eb22b45dc02b2ceac21" => :yosemite
    sha256 "146fde1d57eba22a360b96bf84c6b43272f6be3f1898f4e7d52dabfd38221bf2" => :mavericks
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
