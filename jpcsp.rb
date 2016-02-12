class Jpcsp < Formula
  desc "PSP emulator written in Java"
  homepage "http://jpcsp.org/"
  url "https://github.com/jpcsp/jpcsp.git", :revision => "ee38e26b97fd2b4c8821d6b21ebc2bee3b0e9b0e"
  version "0.7+20160203"
  head "https://github.com/jpcsp/jpcsp.git"

  depends_on "ant" => :build
  depends_on "p7zip" => :build
  depends_on :java => "1.6+"

  def install
    system "ant", "-f", "build-auto.xml", "dist-macosx"
    chmod 0755, "dist/jpcsp-macosx/Jpcsp.app/Contents/MacOS/JavaApplicationStub"
    prefix.install "dist/jpcsp-macosx/Jpcsp.app"
    bin.write_exec_script "#{prefix}/Jpcsp.app/Contents/MacOS/JavaApplicationStub"
    mv "#{bin}/JavaApplicationStub", "#{bin}/jpcsp"
  end

  def caveats; <<-EOS.undent
    ISO/CSO images are to be placed in the following directory:
      #{prefix}/Jpcsp.app/Contents/Resources/Java/umdimages

    To avoid any incidental wipeout upon future updates, change it to
    a safe location (under Options > Settings > General > UMD path folders).
    EOS
  end
end
