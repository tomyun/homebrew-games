class Advancemenu < Formula
  desc "Frontend for AdvanceMAME/MESS"
  homepage "http://www.advancemame.it/menu-readme.html"
  url "https://github.com/amadvance/advancemame/releases/download/advancemenu-2.9/advancemenu-2.9.tar.gz"
  sha256 "c8bc7b363ccded2aa79fc7ce44accde9e661afaa1366aea0a243d2c1c395fa10"

  bottle do
    sha256 "9397437ffb3f526f1d465e1717a05a4806aaa3c4fc7de7de21d57524f3534a4e" => :yosemite
    sha256 "22cf502d1bacbaf923a4ffe1e7259370dd7c2a0be249a9fbf2833f78e63d75a6" => :mavericks
    sha256 "2eb1572dcdd865c48ecc2bb1e6f2ff3313339c8a2d0a337524827da6b7883963" => :mountain_lion
  end

  depends_on "sdl"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install", "LDFLAGS=#{ENV.ldflags}", "mandir=#{man}"
  end

  test do
    system "advmenu", "--version"
  end
end
