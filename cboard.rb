class Cboard < Formula
  desc "Ncurses frontend to XBoard chess engines"
  homepage "http://c-board.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/c-board/0.7.3/cboard-0.7.3.tar.bz2"
  sha256 "8caeabc5cccd35c0f093d36ec0088667530d92e178d328ef345c4c20052d25e2"

  head do
    url "git://repo.or.cz/cboard.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "gettext"
  end

  def install
    system "./autogen.sh" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /cboard #{version} /, shell_output("#{bin}/cboard -v")
  end
end
