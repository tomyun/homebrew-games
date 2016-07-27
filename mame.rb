class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0176.tar.gz"
  version "0.176"
  sha256 "ce69d65fc0431563e5617ce738a504826b73632ad261df53f16b314f67d5a48d"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "89a8d797887bfea6ad6ee55f30ae9054f1fab85f1f2797cafe8f52dc2d97ba4a" => :el_capitan
    sha256 "f06d31b549c19b4d7e5adad75d75dc923d52479d7cd0a18ed6da8066f97bb38f" => :yosemite
    sha256 "0894c17ca3605eb47136c19f27b76a0015f9fa16d89762ec9ebb69d4f08ab86d" => :mavericks
  end

  depends_on :python => :build if MacOS.version <= :snow_leopard
  depends_on "pkg-config" => :build
  depends_on "sdl2"
  depends_on "jpeg"
  depends_on "flac"
  depends_on "sqlite"
  depends_on "portmidi"
  depends_on "portaudio"
  depends_on "libuv"

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
                   "USE_SYSTEM_LIB_PORTAUDIO=1",
                   "USE_SYSTEM_LIB_UV=1"
    bin.install "mame"
    man6.install "docs/man/mame.6"
    doc.install Dir["docs/*.txt", "docs/*.md", "docs/LICENSE"]
    pkgshare.install %w[artwork bgfx hash keymaps plugins samples]
    (pkgshare/"shader").install Dir["src/osd/modules/opengl/shader/*.[vf]sh"]
  end

  test do
    assert shell_output("#{bin}/mame -help").start_with? "MAME v#{version}"
    system "#{bin}/mame", "-validate"
  end
end
