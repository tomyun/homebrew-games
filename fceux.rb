class Fceux < Formula
  desc "The all in one NES/Famicom Emulator"
  homepage "http://fceux.com"
  url "https://downloads.sourceforge.net/project/fceultra/Source%20Code/2.2.3%20src/fceux-2.2.3.src.tar.gz"
  sha256 "4be6dda9a347f941809a3c4a90d21815b502384adfdd596adaa7b2daf088823e"

  bottle do
    cellar :any
    sha256 "56512e7e3f4f874b330928f5a0ba9e30e71c9779772f342df348712e821cf583" => :el_capitan
    sha256 "a4d73c5f9ea1e74c74a3c4d25d3b2ee50f2724e1484a164cbf68636b740bb2cc" => :yosemite
    sha256 "d0bc3e23c70b73ee69ef17e5ceff417fa2d712998630711a66fd95e8df6e15ae" => :mavericks
  end

  deprecated_option "no-gtk" => "without-gtk+3"

  depends_on "pkg-config" => :build
  depends_on "scons" => :build
  depends_on "sdl"
  depends_on "gtk+3" => :recommended

  def install
    # Bypass X11 dependency injection
    # https://sourceforge.net/p/fceultra/bugs/755/
    inreplace "src/drivers/sdl/SConscript", "env.ParseConfig(config_string)", ""

    args = []
    args << "RELEASE=1"
    args << "GTK=0"
    args << "GTK3=1" if build.with? "gtk+3"
    # gdlib required for logo insertion, but headers are not detected
    # https://sourceforge.net/p/fceultra/bugs/756/
    args << "LOGO=0"
    scons *args
    libexec.install "src/fceux"
    pkgshare.install ["output/luaScripts", "output/palettes", "output/tools"]
    (bin/"fceux").write <<-EOS.undent
      #!/bin/bash
      LUA_PATH=#{pkgshare}/luaScripts/?.lua #{libexec}/fceux "$@"
      EOS
  end

  test do
    system "fceux", "-h"
  end
end
