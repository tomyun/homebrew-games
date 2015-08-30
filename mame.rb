class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0165.tar.gz"
  version "0.165"
  sha256 "00959b21d949685106528af7d68b92d8ba51ace72651ad582c2fb033ed77292e"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    revision 1
    sha256 "da09055f71f9b1ec3807b4d17bd1e13f4b0be47fa09a91956ea88f29595c1cab" => :yosemite
    sha256 "c9f0526096edf4d18e33a27cc414e69973a28129f5bb2a2de9169ed5a9d57e4d" => :mavericks
    sha256 "5249566244a12de60e07b63b94f0ce1b4e1b5cf5bff6a85d5dadc48a87f93038" => :mountain_lion
  end

  depends_on "sdl2"
  depends_on "jpeg"
  depends_on "flac"
  depends_on "sqlite"
  depends_on "portmidi"

  def install
    inreplace "scripts/src/main.lua", /(targetsuffix) "\w+"/, '\1 ""'
    system "make", "PTR64=#{MacOS.prefer_64_bit? ? 1 : 0}", # for old Macs
                   "MACOSX_USE_LIBSDL=1",
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
