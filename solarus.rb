class Solarus < Formula
  desc "Action-RPG game engine"
  homepage "http://www.solarus-games.org/"
  url "http://www.solarus-games.org/downloads/solarus/solarus-1.4.5-src.tar.gz"
  sha256 "c251dd65502162a8db586e3559353871b3d6b2d3729e39ca814cf20ada362503"
  head "https://github.com/christopho/solarus.git"

  bottle do
    cellar :any
    sha256 "b85242759dfcbefe43a0daa9b70cd781cc53e4763e3f14efec903d5df1d8734d" => :el_capitan
    sha256 "7756d1ea97ee4967085209d2ddd02159a542400f992aab3a026e7f73d9cab61e" => :yosemite
    sha256 "872f69a071cf26254a5ce3fb0214ca23be983bda097a1daf65cc0d60529fbfed" => :mavericks
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
