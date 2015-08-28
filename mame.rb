class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0165.tar.gz"
  version "0.165"
  sha256 "00959b21d949685106528af7d68b92d8ba51ace72651ad582c2fb033ed77292e"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "ad053c0eac7e76e9f5e88e58c90eb029d8a2da2a78025cf4cad552c76dd87eee" => :yosemite
    sha256 "e7103574f79755e09d1a813a2cb0c7ac36c05250a37c6b4bb4b90db8944b9a42" => :mavericks
    sha256 "7cbd9c9c36bdd1665b76343c971f7847d2955a22a173aeb18ad6833d45241c18" => :mountain_lion
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
