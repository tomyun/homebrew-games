class FsUae < Formula
  desc "Amiga emulator"
  homepage "http://fs-uae.net/"

  stable do
    url "https://fs-uae.net/stable/2.8.0/fs-uae-2.8.0.tar.gz"
    sha256 "45d038125489e1fbc9094d411ba8413d8394f8b3ab8072baba391308ffa47bb3"
  end

  bottle do
    cellar :any
    sha256 "2d8f9a763565acbeab9736692ed7f8568d2e7f1ebe9eb7029cec08e460c0e3b7" => :sierra
    sha256 "67e2c4286abcb9cd8087927533273d4e0234dd5b827b5b6a6d80368b1e56afbd" => :el_capitan
    sha256 "812553c7854e38bc16bd50b67c6fc5bf999cd2e5c9ae1a8166f4e705f5442dd4" => :yosemite
  end

  head do
    url "https://github.com/FrodeSolheim/fs-uae.git"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "libtool" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "sdl2"
  depends_on "libpng"
  depends_on "libmpeg2"
  depends_on "glib"
  depends_on "gettext"
  depends_on "freetype"
  depends_on "glew"
  depends_on "openal-soft" if MacOS.version <= :mavericks

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    mkdir "gen"
    system "make"
    system "make", "install"

    # Remove unncessary files
    (share/"applications").rmtree
    (share/"icons").rmtree
    (share/"mime").rmtree
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/fs-uae --version").chomp
  end
end
