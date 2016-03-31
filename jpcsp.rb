class Jpcsp < Formula
  desc "PSP emulator written in Java"
  homepage "http://jpcsp.org/"
  url "https://github.com/jpcsp/jpcsp.git", :revision => "9bf0cb72568e4c7170c6c5b0a975e0ff2f5205d1"
  version "0.7+20160322"
  head "https://github.com/jpcsp/jpcsp.git"

  bottle do
    cellar :any
    sha256 "e584e73a5ce65f7e7b16448a7ac77c0fb0a78284f95e4dca913633dc7c56ddfb" => :el_capitan
    sha256 "a191fcb7a169c762071b6ad98075582d1044911d41adddcdeeb9fcf5e0db6597" => :yosemite
    sha256 "68ada314543335cd2832d80db2f15a043fda8c22ac7318a3aeb43e452280556f" => :mavericks
  end

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
