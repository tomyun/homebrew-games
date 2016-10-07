class Libspectrum < Formula
  desc "Support library for ZX Spectrum emulator"
  homepage "http://fuse-emulator.sourceforge.net/libspectrum.php"
  url "https://downloads.sourceforge.net/project/fuse-emulator/libspectrum/1.3.0/libspectrum-1.3.0.tar.gz"
  sha256 "b587774da3e089054216e91c49fbcaeb62d499348adfccaee3657888de893e42"

  bottle do
    cellar :any
    sha256 "f83fce81b9afcf251cc52e1908b211b79b2a79a99c0f57f364a5bb934e430121" => :sierra
    sha256 "8db8b35203169a2bf6a8923bfc0a157562d09531922ee16972f00e053d3035c0" => :el_capitan
    sha256 "3afbc11190397e757af1784cd03878722ae2ee42d5d8f02d0c6be627efaa44c8" => :yosemite
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
