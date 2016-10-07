class FuseEmulator < Formula
  desc "Free Unix Spectrum Emulator"
  homepage "http://fuse-emulator.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/fuse-emulator/fuse/1.3.0/fuse-1.3.0.tar.gz"
  sha256 "7aa1d6e057a09ffe661494514115d271f73a79e032bafc7a6fd78db4adce06ad"

  bottle do
    sha256 "c725f48e1bf87e6f7ea7b0a7e15e2745dff6164dc62ffa5673fdc40a121acb39" => :el_capitan
    sha256 "efb2f24905f7311c38e1cb4229906a024be38189117aefe76cd51cb258323d3b" => :yosemite
    sha256 "3a894da71abc9e7c8b3373f63c9b759e9323f2785451a876111f4c9bd6285354" => :mavericks
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
