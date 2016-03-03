class Gearboy < Formula
  desc "Nintendo Game Boy (Color) emulator"
  homepage "https://github.com/drhelius/Gearboy"
  url "https://github.com/drhelius/Gearboy/archive/gearboy-2.2.tar.gz"
  sha256 "7f77cec8897a6b2905a8bf0f1c580755e5b6e605f0f1a48ba09ed919e10b7a16"
  head "https://github.com/drhelius/Gearboy.git"

  bottle do
    cellar :any
    sha256 "1aaec7e67d1d0b23e603cc0c65f72bc48f7c3312f04e8a6d0bbc9bb3d1730d67" => :yosemite
    sha256 "bd312f6475195adfdca99c040e0131f44d6c09f001bd7a7718b3c18720a1342e" => :mavericks
    sha256 "1ddfd4c2033d2212fa3855e127d54a2ef8218084fc101c9dfc07b9fdec47c3a9" => :mountain_lion
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
