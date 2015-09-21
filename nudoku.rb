class Nudoku < Formula
  desc "ncurses based sudoku game"
  homepage "https://jubalh.github.io/nudoku/"
  url "https://github.com/jubalh/nudoku/releases/download/0.2.4/nudoku-0.2.4.tar.xz"
  sha256 "4a5c6ab215ed677e31b968f3aa0c418b91b4e643e4adfade543f533ce6cde53a"

  head do
    url "https://github.com/jubalh/nudoku.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    system "autoreconf", "-i" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /nudoku version #{version}$/, shell_output("#{bin}/nudoku -v")
  end
end
