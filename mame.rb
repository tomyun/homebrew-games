class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0171.tar.gz"
  version "0.171"
  sha256 "e543316e238b02ae80f8de6e1da3eaaac3754bc8370deb7c31a4bc73121763c5"
  revision 1
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "31e5b7f25723e7ea6f853d057ba45d60c93e43ff5cfc0f553eec762465929833" => :el_capitan
    sha256 "dd86716da3d75ffc7f0eecb4ef52d22c9e018d0a01fec4cc9cb3fcc45af0dc5b" => :yosemite
    sha256 "51ab284baaa6118842a76377d66bb13d9cb238323fc6e24eab5313d61afa2b33" => :mavericks
  end

  depends_on :python => :build if MacOS.version <= :snow_leopard
  depends_on "pkg-config" => :build
  depends_on "sdl2"
  depends_on "jpeg"
  depends_on "flac"
  depends_on "sqlite"
  depends_on "portmidi"

  # Needs GCC 4.9 or newer
  fails_with :gcc_4_0
  fails_with :gcc
  ("4.3".."4.8").each do |n|
    fails_with :gcc => n
  end

  def install
    inreplace "scripts/src/main.lua", /(targetsuffix) "\w+"/, '\1 ""'
    inreplace "scripts/src/osd/sdl.lua", "--static", ""
    system "make", "PTR64=#{MacOS.prefer_64_bit? ? 1 : 0}", # for old Macs
                   "USE_LIBSDL=1",
                   "USE_SYSTEM_LIB_EXPAT=", # brewed version not picked up
                   "USE_SYSTEM_LIB_ZLIB=1",
                   "USE_SYSTEM_LIB_JPEG=1",
                   "USE_SYSTEM_LIB_FLAC=1",
                   "USE_SYSTEM_LIB_LUA=", # lua53 not available yet
                   "USE_SYSTEM_LIB_SQLITE3=1",
                   "USE_SYSTEM_LIB_PORTMIDI=1",
                   "USE_SYSTEM_LIB_PORTAUDIO=1" # currently not used yet
    bin.install "mame"
    man6.install "src/osd/sdl/man/mame.6"
    doc.install Dir["docs/*"]
    pkgshare.install %w[artwork hash keymaps samples]
    (pkgshare/"shader").install Dir["src/osd/modules/opengl/shader/*.[vf]sh"]
  end

  test do
    assert shell_output("#{bin}/mame -help").start_with? "MAME v#{version}"
    system "#{bin}/mame", "-validate"
  end
end
