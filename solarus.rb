class Solarus < Formula
  desc "Action-RPG game engine"
  homepage "http://www.solarus-games.org/"
  url "http://www.solarus-games.org/downloads/solarus/solarus-1.5.1-src.tar.gz"
  sha256 "6cd3928a024f7c18a163a1679a92dfff3c37139c5c49fa5348704df5357e8da3"
  head "https://github.com/christopho/solarus.git"

  bottle do
    cellar :any
    sha256 "d589825751eb7dbf9a6d19cad7c04e4326d9c213c50e77aeb9964ae7a2e3ec8f" => :el_capitan
    sha256 "119fcef5923a8062fcadaddced499f33fb29c9c2c42c6cdfbce8ddf52ad926f5" => :yosemite
    sha256 "144e2504a692e5784c1ee4c270b8a88cf6fce766fecf6072a7cd1fd7ec3aaa90" => :mavericks
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
      system "cmake", "..", "-DSOLARUS_GUI=OFF", *std_cmake_args
      system "make", "install"
    end
  end

  test do
    system "#{bin}/solarus-run", "-help"
  end
end
