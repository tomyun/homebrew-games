class Nesemu2 < Formula
  desc "Cycle accurate NES emulator"
  homepage "http://www.nesemu2.com/"
  url "https://github.com/holodnak/nesemu2.git", :revision => "5173f08fda3ad313ad494d4c67f8b3aed18e4e59"
  version "0.6.1+20140930"
  head "https://github.com/holodnak/nesemu2.git"

  depends_on "wla-dx" => :build
  depends_on "sdl"

  def install
    inreplace "make/sources.make", "-framework SDL", "-lSDL"
    inreplace "source/misc/config.c", %r{/usr(/share/nesemu2)}, "#{HOMEBREW_PREFIX}\\1"
    bin.mkpath
    system "make", "install", "INSTALLPATH=#{bin}", "DATAPATH=#{pkgshare}"
  end

  test do
    system "#{bin}/nesemu2", "--mappers"
  end
end
