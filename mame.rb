class Mame < Formula
  desc "Multiple Arcade Machine Emulator"
  homepage "http://mamedev.org/"
  url "https://github.com/mamedev/mame/archive/mame0177.tar.gz"
  version "0.177"
  sha256 "8b86fd7d3341f715eedcf678c2277cbd506a5d68de710cdf3764fc5e91067cb3"
  head "https://github.com/mamedev/mame.git"

  bottle do
    cellar :any
    sha256 "601e039502a807abdd50d9a9bbd7748ac4d8aada02fc91aa6367aea67b74b11e" => :el_capitan
    sha256 "4f61e10147a97d803c3e41652914163c3d0e0565a5c940f329d8a29fe7053b66" => :yosemite
    sha256 "3a9a3b1a59952d88331aa6059ec419d6451e9ef333a63bd6f6fff5da2fd6dca8" => :mavericks
  end

  depends_on :macos => :yosemite
  depends_on "pkg-config" => :build
  depends_on "sphinx-doc" => :build
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
    system "make", "USE_LIBSDL=1",
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
    cd "docs" do
      system "make", "text"
      doc.install Dir["build/text/*"]
      man6.install "man/mame.6"
    end
    pkgshare.install %w[artwork bgfx hash ini keymaps plugins samples uismall.bdf]
  end

  test do
    assert shell_output("#{bin}/mame -help").start_with? "MAME v#{version}"
    system "#{bin}/mame", "-validate"
  end
end
