class Mgba < Formula
  desc "Game Boy Advance emulator"
  homepage "http://mgba.io/"
  url "https://github.com/mgba-emu/mgba/archive/0.4.1.tar.gz"
  sha256 "73ae50b9ad11047e47c8b900a5965d39e4126563778f0bbfb264c5f45893aab5"
  head "https://github.com/mgba-emu/mgba.git"

  bottle do
    sha256 "189c3d5529ca7e300ed8493f4b1c041d8bb7a2f84ffc1604d810e8fbc43504fb" => :el_capitan
    sha256 "f50287a7594c8a0a3fb2a62a49ef11c7d17ff646fc10dcca10bcd1d28671da1e" => :yosemite
    sha256 "fd5482af9d6f528bc8313cba62c2731afc4cad0436979f958d5b9a861ad01841" => :mavericks
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
