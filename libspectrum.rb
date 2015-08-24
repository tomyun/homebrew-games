class Libspectrum < Formula
  desc "Support library for ZX Spectrum emulator"
  homepage "http://fuse-emulator.sourceforge.net/libspectrum.php"
  url "https://downloads.sourceforge.net/project/fuse-emulator/libspectrum/1.1.1/libspectrum-1.1.1.tar.gz"
  sha256 "178d3607af2109b6b8dafac4f91912745b9f3c087319945c3a886bb7fe7989d5"

  bottle do
    cellar :any
    sha256 "e3efaf8fc8244b235eceddcc2e4c4d67426fc998ad8abfa51299f32cb3cc7b75" => :yosemite
    sha256 "9c7a0df553f8107c7457014ad721dda5e02baa8db1ce4f42395c7a1d82cb70fd" => :mavericks
    sha256 "74a4325399792684a82e436ca673c6d1c8b14b4a0f1fdc069436870d8533876f" => :mountain_lion
  end

  head do
    url "http://svn.code.sf.net/p/fuse-emulator/code/trunk/libspectrum"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "libgcrypt" => :recommended
  depends_on "glib" => :recommended
  depends_on "audiofile" => :recommended

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include "libspectrum.h"
      #include <assert.h>

      int main() {
        assert(libspectrum_init() == LIBSPECTRUM_ERROR_NONE);
        assert(strcmp(libspectrum_version(), "#{version}") == 0);
        return 0;
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lspectrum", "-o", "test"
    system "./test"
  end
end
