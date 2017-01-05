class Mgba < Formula
  desc "Game Boy Advance emulator"
  homepage "https://mgba.io/"
  url "https://github.com/mgba-emu/mgba/archive/0.5.2.tar.gz"
  sha256 "3d9fda762e6e0dd26ffbd3cbaa5365dc7ca7ed324cee5c65b7c85eaa3c37c4f3"
  head "https://github.com/mgba-emu/mgba.git"

  bottle do
    cellar :any
    sha256 "21b22bf4632159022e078069a1888d3d0c5c7ade5c1b3a91e8acd0b39d17e9c9" => :sierra
    sha256 "9d6c20fa3a0f4167ae0cd1d1d32355704b56015a8e335389de47842371e7f0a5" => :el_capitan
    sha256 "711f804e8470e5fbee93aae0acc5724575c14d98b0fabec54aacf625f6dbfe5c" => :yosemite
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
      s.gsub! /(add_custom_command\(TARGET \${BINARY_NAME}-qt)/, '#\1'
      # Install .app bundle into prefix, not prefix/Applications
      s.gsub! "Applications", "."
    end

    cmake_args = []
    cmake_args << "-DUSE_EPOXY=OFF"  if build.without? "libepoxy"
    cmake_args << "-DUSE_MAGICK=OFF" if build.without? "imagemagick"
    cmake_args << "-DUSE_FFMPEG=OFF" if build.without? "ffmpeg"
    cmake_args << "-DUSE_PNG=OFF"    if build.without? "libpng"
    cmake_args << "-DUSE_LIBZIP=OFF" if build.without? "libzip"
    cmake_args << "-DBUILD_QT=OFF"   if build.without? "qt5"

    system "cmake", ".", *cmake_args, *std_cmake_args
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
