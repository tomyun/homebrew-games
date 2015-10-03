class Yetris < Formula
  desc "Customizable Tetris for the terminal."
  homepage "http://yetris.alexdantas.net"
  url "https://github.com/alexdantas/yetris/archive/v2.3.0.tar.gz"
  sha256 "720c222325361e855e2dcfec34f8f0ae61dd418867a87f7af03c9a59d723b919"

  def install
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    assert_match "v#{version}", shell_output("#{bin}/yetris --version")
  end
end
