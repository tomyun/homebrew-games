class Fbzx < Formula
  desc "Sinclair Spectrum emulator"
  homepage "http://www.rastersoft.com/fbzx.html"
  url "https://github.com/rastersoft/fbzx/archive/3.0.0.tar.gz"
  sha256 "8c739edd3de599943daea0078220b5c7774fc04b62a24a7a33854e5ee24056f3"

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "pulseaudio"

  def install
    inreplace "src/z80free/Z80free.h", "endian.h", "machine/endian.h"
    inreplace "src/Makefile" do |s|
      s.gsub! "alsa", ""
      s.gsub! /-D D_SOUND_(ALSA|OSS)/, ""
    end
    inreplace "src/llscreen.cpp", %r{(/usr/local/share)}, '\1/fbzx'
    system "make"
    bin.install "src/fbzx"
    pkgshare.install ["data/spectrum-roms", "data/keymap.bmp"]
    doc.install %w[AMSTRAD CAPABILITIES COPYING FAQ README README.TZX VERSIONS]
  end

  test do
    system "fbzx", "-h"
  end
end
