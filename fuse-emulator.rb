class FuseEmulator < Formula
  desc "Free Unix Spectrum Emulator"
  homepage "http://fuse-emulator.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/fuse-emulator/fuse/1.2.0/fuse-1.2.0.tar.gz"
  sha256 "72621b23c31c69a31e97b698761c4a21a209b23f4d53f8b441291c14f6811acb"

  bottle do
    sha256 "58f03ffbbc6f66249255c332eb52fa4f43c6cb6964611457d0246f3bdfbcbe00" => :el_capitan
    sha256 "8537c98db21ac44c02f5cc38b3bc392863f4403b1bb680575ea83d8c53bcda4a" => :yosemite
    sha256 "7cf7ae0c631e95134f4f6dbb9f4bf9a19895e805751615dab2c0ec798d3d6478" => :mavericks
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
