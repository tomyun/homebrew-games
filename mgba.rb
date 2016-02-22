class Mgba < Formula
  desc "Game Boy Advance emulator"
  homepage "http://mgba.io/"
  url "https://github.com/mgba-emu/mgba/archive/0.4.0.tar.gz"
  sha256 "bec8cb17b366ed9a61ea41efe830716215dc8fa08706fc8cdebadfff723c0448"
  revision 1
  head "https://github.com/mgba-emu/mgba.git"

  bottle do
    sha256 "2c60b70aac4267813917474566694d1bdd26c88759ee9d2ea068f15653e9c646" => :el_capitan
    sha256 "9a11d65e9cda5b48a19f4c9b7d76f12a2a19885b496dc43c29aef2432e308f31" => :yosemite
    sha256 "a64b2b2563581863a007682dff44469a294ecd33e2a40371059746db62ad0a11" => :mavericks
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
