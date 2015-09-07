class Liblcf < Formula
  desc "Library for RPG Maker 2000/2003 games data"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/liblcf/archive/0.3.1.tar.gz"
  sha256 "b809b649aaf5c435465c77cd2e3a573817455c54e487410bb04eaea096f4432a"
  head "https://github.com/EasyRPG/liblcf.git"

  bottle do
    cellar :any
    sha256 "b4ff1ddc14bd61dac7cce6ff3a095de6ff7c961a9df0c4749dd9a5cb53b35497" => :yosemite
    sha256 "975940b97e4c6ced79df8431b97f00d0a945fd4651fa4b64108f36e8b5573540" => :mavericks
    sha256 "2426801bc9bff3cf5cf4d8003a527c4864d08798a1f526444e4ad9dd23d664c6" => :mountain_lion
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "icu4c"
  depends_on "expat"

  def install
    system "autoreconf", "-i"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.cpp").write <<-EOS.undent
      #include "lsd_reader.h"
      #include <cassert>

      int main() {
        std::time_t const current = std::time(NULL);
        assert(current == LSD_Reader::ToUnixTimestamp(LSD_Reader::ToTDateTime(current)));
        return 0;
      }
    EOS
    system ENV.cc, "test.cpp", "-I#{include}/liblcf", "-L#{lib}", "-llcf", "-o", "test"
    system "./test"
  end
end
