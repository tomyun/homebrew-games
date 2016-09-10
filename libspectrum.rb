class Libspectrum < Formula
  desc "Support library for ZX Spectrum emulator"
  homepage "http://fuse-emulator.sourceforge.net/libspectrum.php"
  url "https://downloads.sourceforge.net/project/fuse-emulator/libspectrum/1.2.2/libspectrum-1.2.2.tar.gz"
  sha256 "1f8a365df30d7cb2bb5c289163cf122241660cae6dc2cb70687064c847ad12d1"

  bottle do
    cellar :any
    sha256 "a54d6484ba6f3db17d0e070c9f9c00b28bbca4501cc2ed9c4b2252c28e675c43" => :el_capitan
    sha256 "4f80839ceb955a15b52537bcc1d41642cb182f4a61ca862696e4a40a9cf68712" => :yosemite
    sha256 "a9c2fa7226ac31fcaa1c10451c03bd098b94d4d0f990045b4640be76de23cb10" => :mavericks
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
