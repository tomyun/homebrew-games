class Liblcf < Formula
  desc "Library for RPG Maker 2000/2003 games data"
  homepage "https://easy-rpg.org/"
  url "https://github.com/EasyRPG/liblcf/archive/0.3.2.tar.gz"
  sha256 "cf98a43f3f10047bf51e92a472bae2904eb61eb7d9495130e17857324047f529"
  head "https://github.com/EasyRPG/liblcf.git"

  bottle do
    cellar :any
    sha256 "08f123e17b70f5ffff2c0a96f246a84735abbc1ed53b2187a9fdaad15e1643ea" => :el_capitan
    sha256 "f9e96fe39f25f77354ce57923b1be0c84447ee4c7556a9155b27188b440d3b10" => :yosemite
    sha256 "eb97622cbe693e9f87e68746ca35d5949e2ff962832d674cbd6f2030faa08ffd" => :mavericks
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
