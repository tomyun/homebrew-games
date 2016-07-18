class Mgba < Formula
  desc "Game Boy Advance emulator"
  homepage "http://mgba.io/"
  url "https://github.com/mgba-emu/mgba/archive/0.4.1.tar.gz"
  sha256 "73ae50b9ad11047e47c8b900a5965d39e4126563778f0bbfb264c5f45893aab5"
  head "https://github.com/mgba-emu/mgba.git"

  bottle do
    sha256 "78bac667af943aaf92d165c38d0b1c68ab9b69187f25c0d6744f739305cb6292" => :el_capitan
    sha256 "39c35238489f2f510f6370a59643b975bed7d7c91e24333b27e79d35cd00442e" => :yosemite
    sha256 "26a3c1328cf06e2c158bc9d585e2d4ec0e4397db1e8b57161a8c79d840265262" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "ffmpeg" => :recommended
  depends_on "imagemagick" => :recommended
  depends_on "libepoxy" => :recommended
  depends_on "libpng" => :recommended
  depends_on "libzip" => :recommended
  depends_on "qt5" => :recommended
  depends_on "sdl2"

  def install
    inreplace "src/platform/qt/CMakeLists.txt" do |s|
      # Avoid framework installation via tools/deploy-macosx.py
      s.gsub! /(add_custom_command)/, '#\1'
      # Install .app bundle into prefix, not prefix/Applications
      s.gsub! "Applications", "."
    end
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    if build.with? "qt5"
      # Replace SDL frontend binary with a script for running Qt frontend
      # -DBUILD_SDL=OFF would be easier, but disable joystick support in Qt frontend
      rm "#{bin}/mgba"
      bin.write_exec_script "#{prefix}/mGBA.app/Contents/MacOS/mGBA"
    end
  end

  test do
    system "#{bin}/mgba", "-h"
  end
end
