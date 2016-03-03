class Gearsystem < Formula
  desc "Sega Master System / Game Gear emulator"
  homepage "https://github.com/drhelius/Gearsystem"
  url "https://github.com/drhelius/Gearsystem/archive/gearsystem-2.2.tar.gz"
  sha256 "58004ae6cc7497d466213d2b7f00f2f1abbbd2ea900de228e2f392ceb505984a"
  head "https://github.com/drhelius/Gearsystem.git"

  bottle do
    cellar :any
    sha256 "461a8f282d4b2879668be2e493c3a497450a68d3850dccd4d979917793450cfd" => :yosemite
    sha256 "8f90071ca74b6c14d9208fc664fd180aa4e02b3df78b6ef6f664e2fe9c0d490b" => :mavericks
    sha256 "976494cfd5d33a5c7fff92c31b87c51748680023e28ec7b1691609a7d09f6aeb" => :mountain_lion
  end

  depends_on "qt5"
  depends_on "sdl2"

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
