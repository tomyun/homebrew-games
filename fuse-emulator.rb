class FuseEmulator < Formula
  desc "Free Unix Spectrum Emulator"
  homepage "http://fuse-emulator.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/fuse-emulator/fuse/1.3.1/fuse-1.3.1.tar.gz"
  sha256 "2973d50a72a176e308ee89f5930c4b722d47f40f05d32042eee987a921fdf089"

  bottle do
    sha256 "c8be220bd885be72166dfdae2373e1a90e7b8182279129d1816de0bab7b95a72" => :sierra
    sha256 "2de13fb630f6c002ae4ac04d165f1399820c01ca28803f9eb093b94da8360ff2" => :el_capitan
    sha256 "cd9e07a77bc481ff335f9c4fe8414c24cab979e6a1b313eaf07f87b8e12df591" => :yosemite
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
