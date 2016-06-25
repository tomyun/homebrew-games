class Libspectrum < Formula
  desc "Support library for ZX Spectrum emulator"
  homepage "http://fuse-emulator.sourceforge.net/libspectrum.php"
  url "https://downloads.sourceforge.net/project/fuse-emulator/libspectrum/1.2.0/libspectrum-1.2.0.tar.gz"
  sha256 "5d08c624b181b18e708ca82183cae2162a9476dd524c421fbac52fe5ffba1e7a"

  bottle do
    cellar :any
    sha256 "00f56a030c0e8f872b31cf7a604b39a985520adb0c7c80c721c535566f8c0be2" => :el_capitan
    sha256 "c7ccd9faddfcfb022b99362b3c931c4e602857b2c6aa464227411835d8dbd7ae" => :yosemite
    sha256 "af84b7f6a252aee1cb2f7475978022b2b72d348fb44e29d5738635019b448fdb" => :mavericks
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
