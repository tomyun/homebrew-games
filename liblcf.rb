class Liblcf < Formula
  desc "Library for RPG Maker 2000/2003 games data"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/liblcf/archive/0.4.1.tar.gz"
  sha256 "2bc4ae3b57b8d0797ab042b7a52f52e9ae5f80239577db3beccedc6fdeac1f0e"
  head "https://github.com/EasyRPG/liblcf.git"
  revision 1

  bottle do
    cellar :any
    sha256 "32287ee2387b8bea53524b631d62d5fac3c67024e2369a2e3e72e09b47129a26" => :el_capitan
    sha256 "8395fc315cf0e88eda7f60b19c27e9b175ed8e10ba88c0ff8af3ba95335faf70" => :yosemite
    sha256 "0fd712a2af046b757866a27275bcf5cd10661410f4558ed8dbf7d5b5115edd8c" => :mavericks
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
    system ENV.cc, "test.cpp", "-I#{include}/liblcf", "-L#{lib}", "-llcf", "-std=c++11", \
      "-o", "test"
    system "./test"
  end
end
