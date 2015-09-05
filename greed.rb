class Greed < Formula
  desc "Game of consumption"
  homepage "http://www.catb.org/~esr/greed/"
  url "http://www.catb.org/~esr/greed/greed-4.1.tar.gz"
  sha256 "2356151b2f95badcb8ad413ca88ee7022a46b11b2edab5b096de6d033778b1ea"
  head "https://gitlab.com/esr/greed.git"

  def install
    # Handle hard-coded destination
    inreplace "Makefile", "/usr/share/man/man6", man6
    # Make doesn't make directories
    bin.mkpath
    man6.mkpath
    (var/"greed").mkpath
    # High scores will be stored in var/greed
    system "make", "SFILE=#{var}/greed/greed.hs"
    system "make", "install", "BIN=#{bin}"
  end

  def caveats; <<-EOS.undent
    High scores will be stored in the following location:
      #{var}/greed/greed.hs
    EOS
  end

  test do
    File.executable? "#{bin}/greed"
  end
end
