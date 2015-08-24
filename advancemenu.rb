class Advancemenu < Formula
  desc "Frontend for AdvanceMAME/MESS"
  homepage "http://www.advancemame.it/menu-readme.html"
  url "https://github.com/amadvance/advancemame/releases/download/advancemenu-2.8/advancemenu-2.8.tar.gz"
  sha256 "b591f85c9785997f113643f3b3e202ea849888f12553cd622ded83499301f5f5"

  depends_on "sdl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install", "LDFLAGS=#{ENV.ldflags}", "mandir=#{man}"
  end

  test do
    system "advmenu", "--version"
  end
end
