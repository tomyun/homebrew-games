class Solarus < Formula
  desc "Action-RPG game engine"
  homepage "http://www.solarus-games.org/"
  url "http://www.solarus-games.org/downloads/solarus/solarus-1.4.4-src.tar.gz"
  sha256 "ed27330952a2413f017deba3b563e8cd45ea29059ebcdb0ebcdff0f779d87709"
  head "https://github.com/christopho/solarus.git"

  bottle do
    cellar :any
    sha256 "20cb99b7e755776e5d41f9c3a8fe32e421a22d47037d9866bcefab97bcc1a914" => :el_capitan
    sha256 "7748d677b23fc236c8fd48e56ef041f13ce18a82144ab581452718d0420784a0" => :yosemite
    sha256 "d883c70103feba9416b2493929bdbc4e323102b63f600fe84a86234a06bb4805" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_ttf"
  depends_on "libvorbis"
  depends_on "libogg"
  depends_on "libmodplug"
  depends_on "physfs"
  depends_on "luajit"

  def install
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/solarus_run", "-help"
  end
end
