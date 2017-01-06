class Mgba < Formula
  desc "Game Boy Advance emulator"
  homepage "https://mgba.io/"
  url "https://github.com/mgba-emu/mgba/archive/0.5.2.tar.gz"
  sha256 "3d9fda762e6e0dd26ffbd3cbaa5365dc7ca7ed324cee5c65b7c85eaa3c37c4f3"
  head "https://github.com/mgba-emu/mgba.git"

  bottle do
    cellar :any
    sha256 "8f6948ce5e2cbb9c3f3aaa36a5535c41c1d40f7f985722853ea9aa55fbb741fc" => :sierra
    sha256 "b1bdcdc3aa6abb4bf975b142ebedad8aa44138910deb369e33c789f0e49a73f0" => :el_capitan
    sha256 "661a6e5166d2cd3a2e2a9af0f076363b4c5addac688f45c1a6fc7b7ec67328d7" => :yosemite
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
