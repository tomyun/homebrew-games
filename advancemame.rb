class Advancemame < Formula
  desc "MAME with advanced video support"
  homepage "http://www.advancemame.it/"
  url "https://github.com/amadvance/advancemame/releases/download/advancemame-1.4/advancemame-1.4.tar.gz"
  sha256 "525e0897cd41fe8d3ef563e59592da740ebe005eda0948515dca410d01624bcc"

  depends_on "sdl"
  depends_on "freetype"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install", "mandir=#{man}", "docdir=#{doc}"
  end

  test do
    system "#{bin}/advmame", "--version"
  end
end
