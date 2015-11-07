class DwarfFortress < Formula
  desc "Open-ended rogelike game"
  homepage "http://bay12games.com/dwarves/"
  url "http://bay12games.com/dwarves/df_40_24_osx.tar.bz2"
  version "0.40.24"
  sha256 "653837ed073ffe2825d25bc80f0967d6a8ccb9bf869a188d4bd4320154630936"

  depends_on :x11

  def install
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
