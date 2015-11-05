class ColorCode < Formula
  desc "Free advanced MasterMind clone"
  homepage "http://colorcode.laebisch.com/"
  url "http://colorcode.laebisch.com/download/ColorCode-0.7.2.tar.gz"
  sha256 "d1c5bf4d65c81de16c4159c2c69c096fc7ff47cca587d7233985e078d63c79aa"

  depends_on "qt"

  def install
    system "qmake"
    system "make"
    prefix.install "ColorCode.app"
    bin.write_exec_script "#{prefix}/ColorCode.app/Contents/MacOS/colorcode"
  end

  test do
    system "#{bin}/colorcode", "-h"
  end
end
