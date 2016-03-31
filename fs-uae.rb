class FsUae < Formula
  desc "Amiga emulator"
  homepage "http://fs-uae.net/"

  stable do
    url "http://fs-uae.net/fs-uae/stable/2.6.2/fs-uae-2.6.2.tar.gz"
    sha256 "31328e8da0d31d85ce5ce46830698b83c0ce04dfe6b0f5df6fd3529dba3c0dd4"
  end

  bottle do
    cellar :any
    sha256 "40b43f2ccddebdcc73fc535f4a1205b351eb183a5c1a384d7a1d6e527ad83179" => :el_capitan
    sha256 "584250abc8bf470514c6a90fa36c3c6e8917b4ff7440ff6b8ca9939720096c46" => :yosemite
    sha256 "ad383c90a7642364e678a6e328e14ba520cbeac9cbf65d2d9e740c14bd50ec72" => :mavericks
  end

  devel do
    url "http://fs-uae.net/fs-uae/devel/2.7.9dev/fs-uae-2.7.9dev.tar.gz"
    version "2.7.9dev"
    sha256 "4dd7c5f2e078bcec7d4a597e3a496e6afe49edb1a46aeab8ed79287d9cf9bbe0"
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
    assert_equal "#{version}", shell_output("#{bin}/fs-uae --version").chomp
  end
end
