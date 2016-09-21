class Myman < Formula
  desc "Text-mode videogame inspired by Namco's Pac-Man"
  homepage "http://myman.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/myman/myman-cvs/myman-cvs-2009-10-30/myman-wip-2009-10-30.tar.gz"
  sha256 "bf69607eabe4c373862c81bf56756f2a96eecb8eaa8c911bb2abda78b40c6d73"
  head ":pserver:anonymous:@myman.cvs.sourceforge.net:/cvsroot/myman", using: :cvs

  bottle do
    sha256 "af34480e0b48213a90fbf0fcae7bc387614f90b1950b54dc894281eed9413508" => :el_capitan
    sha256 "e47205a17d13c97382bdf1ff5f1d64e45060e63592633c21fb42393854965628" => :yosemite
    sha256 "53ce0852a35f8d7de924dc952e85903a2c17a0dcaecadda9344fb3262fb33a09" => :mavericks
  end

  depends_on "coreutils" => :build
  depends_on "gnu-sed" => :build
  depends_on "homebrew/dupes/groff" => :build

  def install
    ENV["RMDIR"] = "grmdir"
    ENV["SED"] = "gsed"
    ENV["INSTALL"] = "ginstall"
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/myman", "-k"
  end
end
