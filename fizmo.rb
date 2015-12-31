class Fizmo < Formula
  desc "Z-Machine interpreter"
  homepage "https://christoph-ender.de/fizmo/"
  url "https://christoph-ender.de/fizmo/source/fizmo-0.7.10.tar.gz"
  sha256 "0e3561492ece58ff60eba768f3b2cfa943ba111736b0f63b775e3face590462b"

  bottle do
    sha256 "f79c34c31907d62cd7594147ea29813696defa32c95a4cde25e1ccc91c67d99a" => :el_capitan
    sha256 "21430a6429d3986046fd7dae6d1be791cf837167a328a0ad747a043ce77a148c" => :yosemite
    sha256 "4a369ed00e66881e5b9c7f2513eb9c1e459b2df3db11e3a084ba9579675a7062" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on :x11
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libsndfile"
  depends_on "sdl2"

  def install
    ENV["ncursesw_CFLAGS"] = "-I#{MacOS.sdk_path}/usr/include"
    ENV["ncursesw_LIBS"] = "-L#{MacOS.sdk_path}/usr/lib -lncurses"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make", "install"
  end

  test do
    assert_match /libfizmo version #{version}\.$/, shell_output("#{bin}/fizmo-console --help")
  end
end
