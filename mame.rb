class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0165.tar.gz"
  version "0.165"
  sha256 "00959b21d949685106528af7d68b92d8ba51ace72651ad582c2fb033ed77292e"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "03c8c00fb3f3091fb7bf508cd53bbbb715e34ac3b5f745f27a70f8b3cca8ab32" => :yosemite
    sha256 "94685ff1bad20b424f3f9bfa6cfac73f9a938aa8c80b5129def2592f179931c1" => :mavericks
    sha256 "1ecb32b9e6a014d87c321420bbda325223dfaac04467dfa72e1e2a26a6ee1483" => :mountain_lion
  end

  depends_on :python => :build
  depends_on "sdl2"
  depends_on "jpeg"
  depends_on "flac"
  depends_on "sqlite"
  depends_on "portmidi"

  def install
    inreplace "scripts/src/main.lua", /(targetsuffix) "\w+"/, '\1 ""'
    system "make", "MACOSX_USE_LIBSDL=1",
                   "USE_SYSTEM_LIB_EXPAT=", # brewed version not picked up
                   "USE_SYSTEM_LIB_ZLIB=1",
                   "USE_SYSTEM_LIB_JPEG=1",
                   "USE_SYSTEM_LIB_FLAC=1",
                   "USE_SYSTEM_LIB_LUA=", # lua53 not available yet
                   "USE_SYSETM_LIB_SQLITE3=1",
                   "USE_SYSTEM_LIB_PORTMIDI=1",
                   "USE_SYSTEM_LIB_PORTAUDIO=1" # currently not used yet
    bin.install "mame"
    man6.install "src/osd/sdl/man/mame.6"
  end

  test do
    assert shell_output("#{bin}/mame -help").start_with? "M.A.M.E. v#{version}"
    system "#{bin}/mame", "-validate"
  end
end
