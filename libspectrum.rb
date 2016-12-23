class Libspectrum < Formula
  desc "Support library for ZX Spectrum emulator"
  homepage "http://fuse-emulator.sourceforge.net/libspectrum.php"
  url "https://downloads.sourceforge.net/project/fuse-emulator/libspectrum/1.3.2/libspectrum-1.3.2.tar.gz"
  sha256 "c7d7580097116a7afd90f1e3d000e4b7a66b20178503f11e03b3a95180208c3f"

  bottle do
    cellar :any
    sha256 "09057d06bafa34529a3a5462a58a7179743cc6e899ec97d988157a2b760fbec0" => :sierra
    sha256 "eb223fc24e5057a537de02f3355da71c1cb44dd72c0c21d18d70397e2a5dad57" => :el_capitan
    sha256 "5fc1d07799e523894994fff670929bf5072c6d87edf0d234800d5bd0c946f0e1" => :yosemite
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
