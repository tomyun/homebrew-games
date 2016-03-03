class Gearboy < Formula
  desc "Nintendo Game Boy (Color) emulator"
  homepage "https://github.com/drhelius/Gearboy"
  url "https://github.com/drhelius/Gearboy/archive/gearboy-2.2.tar.gz"
  sha256 "7f77cec8897a6b2905a8bf0f1c580755e5b6e605f0f1a48ba09ed919e10b7a16"
  head "https://github.com/drhelius/Gearboy.git"

  bottle do
    cellar :any
    sha256 "0988f7f5ee50f56f69f1f98d0d5b43b28b525cf9cea0a1f8871da962a21b9c82" => :el_capitan
    sha256 "1e277e15aa45db62885fd40a58de1823076e3fdb99ecb81c068e1f611fa3dfef" => :yosemite
    sha256 "f07a190fce2b1373b08a34cce2289a0918d266856a068f12deed4689924ce789" => :mavericks
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
