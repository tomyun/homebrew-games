class Advancemess < Formula
  desc "MESS with advanced video support"
  homepage "http://www.advancemame.it/"
  url "https://github.com/amadvance/advancemame/releases/download/advancemess-1.4/advancemess-1.4.tar.gz"
  sha256 "0d78a56075adeb8ffc1716205e195ee4e005d8799067858d398a4e7750151d00"

  depends_on "sdl"
  depends_on "freetype"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make"
    system "make", "install", "mandir=#{man}", "docdir=#{doc}"
  end

  test do
    system "#{bin}/advmess", "--version"
  end
end
