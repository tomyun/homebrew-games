class FsUae < Formula
  desc "Amiga emulator"
  homepage "http://fs-uae.net/"

  stable do
    url "http://fs-uae.net/fs-uae/stable/2.6.1/fs-uae-2.6.1.tar.gz"
    sha256 "e5506f18017449fcc1e63e1186720c10beeff0fac44fb53cb08c4fb3bca74ba7"
  end

  devel do
    url "http://fs-uae.net/fs-uae/devel/2.7.0dev/fs-uae-2.7.0dev.tar.gz"
    version "2.7.0dev"
    sha256 "e34e2eedba97f177124737bdaf64b7ef1d6607de45f56da9667e84ca39fff82b"
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
  depends_on "glib"
  depends_on "gettext"
  depends_on "freetype"
  depends_on "glew"

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
    assert_equal "#{version}", shell_output("#{bin}/fs-uae --version").chomp
  end
end
