class TtySolitaire < Formula
  desc "Ncurses-based klondike solitaire game"
  homepage "https://github.com/mpereira/tty-solitaire"
  url "https://github.com/mpereira/tty-solitaire/archive/v0.2.1.tar.gz"
  sha256 "ed83b71f16bb477f2870bfca59dd4480f9bd204cccb7155315978f88916abee1"

  bottle do
    cellar :any_skip_relocation
    sha256 "be50a8c8efd4b0d6e400be67e23b655ab39cda9420bef1b89bb2fea4447439a4" => :el_capitan
    sha256 "edce5a6e4ec649811948a751094cdae28763a765131c06046b9251eca152b549" => :yosemite
    sha256 "0c7c9114a1bbbc94be747456c2cc60a75f412b47a2852d04f8cac80a993a0e6a" => :mavericks
  end

  def install
    system "make"
    system "make", "install", "PREFIX=#{prefix}"
  end

  test do
    system "#{bin}/ttysolitaire", "-h"
  end
end
