class DwarfFortress < Formula
  desc "Open-ended rogelike game"
  homepage "http://bay12games.com/dwarves/"
  url "http://www.bay12games.com/dwarves/df_43_01_osx.tar.bz2"
  version "0.43.01"
  sha256 "7fe378b7aeee67f10a1f88a2341b8724edbf91795fd928506f01dfb403304d43"

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
