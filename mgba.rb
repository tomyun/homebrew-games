class Mgba < Formula
  desc "Game Boy Advance emulator"
  homepage "http://mgba.io/"
  url "https://github.com/mgba-emu/mgba/archive/0.3.2.tar.gz"
  sha256 "119fae887df51b28adc807ffe264dfc0f4d872fdd75f60eb2855bd2662fd0b64"
  head "https://github.com/mgba-emu/mgba.git"

  bottle do
    sha256 "18a2c503009274918388d91eff2a3fd17b92278474a0c44f01c7629e65b58d36" => :el_capitan
    sha256 "23b99aa31be27eb98bb08e89d4cb313ef0a3fbc6420d6168f919dbf120ef9fe6" => :yosemite
    sha256 "bd420d2c6993ebe5f20221d8a728da35072d98236c3eb3abf01c2536536152c9" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "ffmpeg" => :recommended
  depends_on "imagemagick" => :recommended
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
