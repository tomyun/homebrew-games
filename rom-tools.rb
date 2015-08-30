class RomTools < Formula
  desc "Tools for Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0165.tar.gz"
  version "0.165"
  sha256 "00959b21d949685106528af7d68b92d8ba51ace72651ad582c2fb033ed77292e"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "72368ee98a38f733485603626d12e4c79478c11f581d473977c9856ef692909c" => :yosemite
    sha256 "b8b55af265043b210d7f3680f93b2242f53c367c852112961cbb0752a62a1dc0" => :mavericks
    sha256 "2ba79cf6cbc99e0f197a2082788ed044f6e4964d010b00842b0a2782192c25ba" => :mountain_lion
  end

  depends_on "sdl2"
  depends_on "flac"
  depends_on "sqlite"
  depends_on "portmidi"

  # FIXME: prevent build failure, fixed upstream
  # https://github.com/mamedev/mame/pull/292
  patch do
    url "https://github.com/mamedev/mame/commit/2afb39374410d803dd287f83de44fbf7a4c2edc8.diff"
    sha256 "0419953fc46170e2e114fbd369cfa461894b30a8c54c4729917b31575ed078a8"
  end

  def install
    inreplace "scripts/src/main.lua", /(targetsuffix) "\w+"/, '\1 ""'
    system "make", "TARGET=ldplayer", "TOOLS=1",
                   "PTR64=#{MacOS.prefer_64_bit? ? 1 : 0}", # for old Macs
                   "MACOSX_USE_LIBSDL=1",
                   "USE_SYSTEM_LIB_ZLIB=1",
                   "USE_SYSTEM_LIB_FLAC=1",
                   "USE_SYSTEM_LIB_PORTMIDI=1"
    bin.install %W[
      castool chdman floptool imgtool jedutil ldplayer ldresample ldverify nltool nlwav pngcmp
      regrep romcmp src2html srcclean testkeys unidasm
    ]
    bin.install "split" => "rom-split"
    man1.install Dir["src/osd/sdl/man/*.1"]
  end

  # Needs more comprehensive tests
  test do
    system "#{bin}/castool"
    # system "#{bin}/chdman"
    system "#{bin}/floptool"
    system "#{bin}/imgtool", "listformats"
    system "#{bin}/jedutil", "-viewlist"
    system "#{bin}/ldplayer", "-help"
    # system "#{bin}/ldresample"
    # system "#{bin}/ldverify"
    # system "#{bin}/nltool", "--help" # segmentation fault
    # system "#{bin}/nlwav", "--help" # segmentation fault
    # system "#{bin}/pngcmp"
    # system "#{bin}/regrep"
    system "#{bin}/romcmp"
    system "#{bin}/rom-split"
    # system "#{bin}/src2html"
    # system "#{bin}/srcclean"
    # system "#{bin}/testkeys"
    # system "#{bin}/unidasm"
  end
end
