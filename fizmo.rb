class Fizmo < Formula
  desc "Z-Machine interpreter"
  homepage "https://fizmo.spellbreaker.org"
  url "https://fizmo.spellbreaker.org/source/fizmo-0.8.2.tar.gz"
  sha256 "369c3b58e019756229bf7e72cc5b15c049f1d6d5c65d7653267e67cef109e675"

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
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make", "install"
  end

  test do
    system "#{bin}/fizmo-console", "--help"
    # Unable to test headless ncursew client
    # https://github.com/Homebrew/homebrew-games/pull/366
    # system "#{bin}/fizmo-ncursesw", "--help"
    system "#{bin}/fizmo-sdl2", "--help"
  end
end
