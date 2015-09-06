class GnuGo < Formula
  desc "GNU Go"
  homepage "https://www.gnu.org/software/gnugo/gnugo.html"
  url "http://ftpmirror.gnu.org/gnugo/gnugo-3.8.tar.gz"
  mirror "https://ftp.gnu.org/gnu/gnugo/gnugo-3.8.tar.gz"
  sha256 "da68d7a65f44dcf6ce6e4e630b6f6dd9897249d34425920bfdd4e07ff1866a72"
  head "git://git.savannah.gnu.org/gnugo.git"

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
