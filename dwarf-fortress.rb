class DwarfFortress < Formula
  desc "Open-ended rogelike game"
  homepage "http://bay12games.com/dwarves/"
  url "http://www.bay12games.com/dwarves/df_42_06_osx.tar.bz2"
  version "0.42.06"
  sha256 "50ff2c0b8a6a2c041cc53a7860f9e8ee421fb91d93aaf6b8d55d9d646b68f21a"

  bottle do
    cellar :any
    sha256 "daeea3c158f9454f407db39e5f3f171a3f005f69fb2243435ca89be1f2decd1e" => :el_capitan
    sha256 "8888b73196f4b418def57fd07ff78f448d1e73358dd05ae800b60b24e737e274" => :yosemite
    sha256 "e6f11aac3f9c1aab30a9f8fa3bf10557e9b1cf176b6faa121065a2e9f1507257" => :mavericks
  end

  depends_on :arch => :intel
  depends_on :x11

  def install
    # Dwarf Fortress uses freetype from X11, but hardcodes a path that
    # isn't installed by modern XQuartz. Point it at wherever XQuartz
    # happens to be on the user's system.
    system "install_name_tool", "-change",
                                "/usr/X11/lib/libfreetype.6.dylib",
                                "#{MacOS::XQuartz.prefix}/lib/libfreetype.6.dylib",
                                "libs/SDL_ttf.framework/SDL_ttf"

    (bin/"dwarffortress").write <<-EOS.undent
      #!/bin/sh
      exec #{libexec}/df
    EOS
    rm_rf "sdl" # only contains a readme
    libexec.install Dir["*"]
  end

  def caveats; <<-EOS.undent
      If you're using a retina display, the PRINT_MODE should
      be changed to STANDARD in #{libexec}/data/init/init.txt
    EOS
  end
end
