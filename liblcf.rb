class Liblcf < Formula
  desc "Library for RPG Maker 2000/2003 games data"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/liblcf/archive/0.4.0.tar.gz"
  sha256 "a85e471f55445b3e746429c8bf9d27d1b3a7f86d4f86ed74c282791c9c696291"
  head "https://github.com/EasyRPG/liblcf.git"

  bottle do
    cellar :any
    sha256 "dec84c5a15636d1b47f8ad4e09202a29bb6cdc22489ec1aaee6bb2b10aab8ce3" => :el_capitan
    sha256 "93a6be4e7d67235f9492678dee8adabc18d5ed1f93c1f657619c072943de06e9" => :yosemite
    sha256 "5fa1cd94186fa8c59c3aa0dd60920fbde6bc8ca7ece3e2ce7bd07fe7afd4ca80" => :mavericks
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
