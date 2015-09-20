class Nettoe < Formula
  desc "Tic Tac Toe-like game for the console"
  homepage "http://nettoe.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/nettoe/nettoe/1.5.1/nettoe-1.5.1.tar.gz"
  sha256 "dbc2c08e7e0f7e60236954ee19a165a350ab3e0bcbbe085ecd687f39253881cb"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /netToe #{version} /, shell_output("#{bin}/nettoe -v")
  end
end
