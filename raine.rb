class Raine < Formula
  desc "680x0 arcade emulator"
  homepage "http://raine.1emulation.com/"
  url "https://github.com/zelurker/raine/archive/0.64.12.tar.gz"
  sha256 "8189867e8c600571a29f371be5ca310b37c5e5f85d485256f312bc09bc987e3c"
  head "https://github.com/zelurker/raine.git"

  bottle do
    cellar :any
    sha256 "0da489ac01078c8a72938de42de7215f5357ad03e45db66013d6638359a5754d" => :el_capitan
    sha256 "d48acf976fd49d55abcf20125199a6b13c88733b25124176c0f0daea2a3f4ec7" => :yosemite
    sha256 "1c3315ab18fd833a5285e2596a6271a184ed3f2d4f74e228b1c3b400059de61b" => :mavericks
  end

  depends_on "gettext" => "universal"
  depends_on "libpng" => "universal"
  depends_on "sdl" => "universal"
  depends_on "sdl_image" => "universal"
  depends_on "sdl_sound" => ["universal", "with-flac", "with-libogg", "with-libvorbis"]
  depends_on "sdl_ttf" => "universal"
  depends_on "muparser" => "universal"
  depends_on "nasm" => :build

  depends_on "flac" => "universal" # for sdl_sound
  depends_on "freetype" => "universal" # for sdl_ttf
  depends_on "xz" => "universal" # for sdl_sound, etc.

  def install
    ENV.m32
    inreplace "makefile" do |s|
      s.gsub! /-framework (SDL|SDL_image|SDL_ttf)/, "-l\\1"
      s.gsub! %r{/usr/local/lib/libSDL_sound\.a}, "-lSDL_sound"
      s.gsub! %r{/usr/local/lib/libintl\.a}, "-lintl"
      s.gsub! %r{/usr/local/lib/libmuparser\.a}, "-lmuparser"
    end
    system "make"
    system "make", "install"
    prefix.install "Raine.app"
    bin.write_exec_script "#{prefix}/Raine.app/Contents/MacOS/raine"
  end

  test do
    assert_match /RAINE \(680x0 Arcade Emulation\) #{version} /, shell_output("#{bin}/raine -n")
  end
end
