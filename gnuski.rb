class Gnuski < Formula
  desc "Open source clone of Skifree"
  homepage "http://gnuski.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/gnuski/gnuski/gnuski-0.3/gnuski-0.3.tar.gz"
  sha256 "1b629bd29dd6ad362b56055ccdb4c7ad462ff39d7a0deb915753c2096f5f959d"

  def install
    system "make"
    bin.install "gnuski"
  end
end
