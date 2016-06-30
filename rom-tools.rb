class RomTools < Formula
  desc "Tools for Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0175.tar.gz"
  version "0.175"
  sha256 "b24a889cff0fa98c04e0a14dc06f72ba8dbec57b251a01cdd201da1824a3afd4"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "3c88d1cae8f60f12ab8b4dda74dc23d1dbcafcfa5dd0535a797590e6931fbad1" => :el_capitan
    sha256 "dbc177fd66b266b083ec4a2fb9b900d2c6dd39eadc268f3506da07d63fb9c1d9" => :yosemite
    sha256 "fd39ca918a1d48cbdaf250a394fd5407eaf9f36bf2667a89282916a764f191da" => :mavericks
  end

  depends_on :python => :build if MacOS.version <= :snow_leopard
  depends_on "pkg-config" => :build
  depends_on "sdl2"
  depends_on "flac"
  depends_on "sqlite"
  depends_on "portmidi"

  # Fix ldplayer compile error (fixed upstream)
  patch do
    url "https://github.com/mamedev/mame/commit/9a2ab78eb5e25cf1c3700635054177533c034c86.diff"
    sha256 "1519f8f4f735b03e3f0355f4da14f2ffae1c63ebe90b2214d9786d66446ae1e4"
  end

  def install
    inreplace "scripts/src/main.lua", /(targetsuffix) "\w+"/, '\1 ""'
    inreplace "scripts/src/osd/sdl.lua", "--static", ""
    system "make", "TARGET=ldplayer", "TOOLS=1",
                   "PTR64=#{MacOS.prefer_64_bit? ? 1 : 0}", # for old Macs
                   "USE_LIBSDL=1",
                   "USE_SYSTEM_LIB_ZLIB=1",
                   "USE_SYSTEM_LIB_FLAC=1",
                   "USE_SYSTEM_LIB_PORTMIDI=1"
    bin.install %W[
      aueffectutil castool chdman floptool imgtool jedutil ldplayer ldresample
      ldverify nltool nlwav pngcmp regrep romcmp src2html srcclean unidasm
    ]
    bin.install "split" => "rom-split"
    man1.install Dir["docs/man/*.1"]
  end

  # Needs more comprehensive tests
  test do
    # system "#{bin}/aueffectutil" # segmentation fault
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
    system "#{bin}/srcclean"
    # system "#{bin}/unidasm"
  end
end
