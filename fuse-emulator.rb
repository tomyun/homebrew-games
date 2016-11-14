class FuseEmulator < Formula
  desc "Free Unix Spectrum Emulator"
  homepage "http://fuse-emulator.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/fuse-emulator/fuse/1.3.1/fuse-1.3.1.tar.gz"
  sha256 "2973d50a72a176e308ee89f5930c4b722d47f40f05d32042eee987a921fdf089"

  bottle do
    sha256 "3b93ccf5a5da1b34c0d0777681cd8cd29205936f4ba893d6d12a0a6c16a667f2" => :sierra
    sha256 "1129793303fda8377f596d5964a223a2a13ae57df55b8632df7785c7e5bef502" => :el_capitan
    sha256 "5e9e85d9faee4448877ed645af7fd1ac55f111979c0a3c5e31a1755b243b98f6" => :yosemite
  end

  head do
    url "http://svn.code.sf.net/p/fuse-emulator/code/trunk/fuse"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "libspectrum"
  depends_on "libpng"

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-sdltest",
                          "--with-sdl",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/fuse", "--version"
  end
end
