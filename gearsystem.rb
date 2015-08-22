class Gearsystem < Formula
  desc "Sega Master System / Game Gear emulator"
  homepage "https://github.com/drhelius/Gearsystem"
  url "https://github.com/drhelius/Gearsystem/archive/gearsystem-2.1.tar.gz"
  sha256 "6da587157bac694045d7bbdd79e41ca3f900011191a4331fa54a88aa4b536fde"
  head "https://github.com/drhelius/Gearsystem.git"

  depends_on "qt5"
  depends_on "sdl2"

  # Fix rendering glitches on Mac OS X
  patch do
    url "https://patch-diff.githubusercontent.com/raw/drhelius/Gearsystem/pull/7.diff"
    sha256 "353288034539b350eff71ca8bf47e9e619a149256944d335722e62d4f6d01c1b"
  end

  def install
    cd "platforms/macosx/Gearsystem" do
      inreplace "Gearsystem.pro" do |s|
        s.gsub! "/usr/local/include", "#{Formula["sdl2"].include}"
        s.gsub! "/usr/local/lib", "#{Formula["sdl2"].lib}"
      end
      system "#{Formula["qt5"].bin}/qmake", "PREFIX=#{prefix}", "CONFIG+=c++11"
      system "make"
      prefix.install "Gearsystem.app"
      bin.write_exec_script "#{prefix}/Gearsystem.app/Contents/MacOS/Gearsystem"
    end
  end
end
