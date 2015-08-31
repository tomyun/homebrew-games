class FuseEmulator < Formula
  desc "Free Unix Spectrum Emulator"
  homepage "http://fuse-emulator.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/fuse-emulator/fuse/1.1.1/fuse-1.1.1.tar.gz"
  sha256 "a857d4bd62e01d18429897467508af15624cbaf343caed8b9ba1ab3a8879444e"

  bottle do
    sha256 "d8ec4e9ca09fc74f3a0f31ae8a0c627d8cefc4b1e36fb05fb6254889dde1502c" => :yosemite
    sha256 "26374b7ab68ca721cb35f76c62258903fdc60e4b655f613e3e7167af10d77798" => :mavericks
    sha256 "c370112cf115f50113fa95fb39675e6b05231c9985b5bfc1f00a0c5f5c152ec5" => :mountain_lion
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
