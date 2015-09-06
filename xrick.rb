class Xrick < Formula
  desc "Clone of Rick Dangerous"
  homepage "http://www.bigorno.net/xrick/"
  url "http://www.bigorno.net/xrick/xrick-021212.tgz"
  sha256 "aa8542120bec97a730258027a294bd16196eb8b3d66134483d085f698588fc2b"

  depends_on "sdl"

  def install
    inreplace "src/xrick.c", "data.zip", "#{pkgshare}/data.zip"
    system "make"
    bin.install "xrick"
    man6.install "xrick.6.gz"
    pkgshare.install "data.zip"
  end

  test do
    assert_match "xrick [version ##{version}]", shell_output("#{bin}/xrick --help", 1)
  end
end
