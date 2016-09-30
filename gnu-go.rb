class GnuGo < Formula
  desc "GNU Go"
  homepage "https://www.gnu.org/software/gnugo/gnugo.html"
  url "https://ftpmirror.gnu.org/gnugo/gnugo-3.8.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gnugo/gnugo-3.8.tar.gz"
  sha256 "da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72"
  revision 1
  head "git://git.savannah.gnu.org/gnugo.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "57ccdefc160d72addd7bcad4d4254671193329f87925d514968056922faa305a" => :el_capitan
    sha256 "7948fd7279d67d8894c6abf1ba9b0dc56bae40be2b6084fad703dc62d70bc5ca" => :yosemite
    sha256 "b62358ec7d3aad424e073fa4db20a69c03c5f5629b9467af420f76a5fdca1c75" => :mavericks
  end

  def install
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}",
                          "--with-readline"
    system "make", "install"
  end

  test do
    assert_match /GNU Go #{version}$/, shell_output("#{bin}/gnugo --version")
  end
end
