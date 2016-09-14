class Gearboy < Formula
  desc "Nintendo Game Boy (Color) emulator"
  homepage "https://github.com/drhelius/Gearboy"
  url "https://github.com/drhelius/Gearboy/archive/gearboy-2.3.tar.gz"
  sha256 "7dcc89857ac63d469705c818f012fe4addbac831eb0bba292f56c2d7427cee6b"
  head "https://github.com/drhelius/Gearboy.git"

  bottle do
    cellar :any
    sha256 "e3d8b1a71e83e4a8503e52c37d913c9cc2aef92d7a43e66248bb7077a7e9314a" => :el_capitan
    sha256 "1936e6577992dc5a827fa4c38ca4c8dad3f71a33549127848e9a84b0e6d4c4db" => :yosemite
    sha256 "15a1efe26067a69f580889121f7d10fc120c44d7ed5649e0485965f448cb19d3" => :mavericks
  end

  depends_on "qt5"
  depends_on "sdl2"

  def install
    cd "platforms/macosx/Gearboy" do
      inreplace "Gearboy.pro" do |s|
        s.gsub! "/usr/local/include", "#{Formula["sdl2"].include}"
        s.gsub! "/usr/local/lib", "#{Formula["sdl2"].lib}"
      end
      system "#{Formula["qt5"].bin}/qmake", "PREFIX=#{prefix}", "CONFIG+=c++11"
      system "make"
      prefix.install "Gearboy.app"
      bin.write_exec_script "#{prefix}/Gearboy.app/Contents/MacOS/Gearboy"
    end
  end
end
