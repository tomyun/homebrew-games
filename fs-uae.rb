class FsUae < Formula
  desc "Amiga emulator"
  homepage "http://fs-uae.net/"

  stable do
    url "http://fs-uae.net/fs-uae/stable/2.6.1/fs-uae-2.6.1.tar.gz"
    sha256 "e5506f18017449fcc1e63e1186720c10beeff0fac44fb53cb08c4fb3bca74ba7"
  end

  bottle do
    cellar :any
    sha256 "da99ed33136b7933ebf502f6d8c5c27ff3e58e196540ffa58d83c9c3a0d77cf4" => :el_capitan
    sha256 "a37024708147145117bea38119736ad49302fce8a2840f9cc6d37946e4e08673" => :yosemite
    sha256 "6fd5ccb0e18f51578b192ebfd7bbba75d74088b7c7e55645bdc0a4109ae7623b" => :mavericks
  end

  devel do
    url "http://fs-uae.net/fs-uae/devel/2.7.1dev/fs-uae-2.7.1dev.tar.gz"
    version "2.7.1dev"
    sha256 "8239fcdff87437961e2de3b935eb7e787657bf440f4e4cec0838c598fa7083cd"
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
