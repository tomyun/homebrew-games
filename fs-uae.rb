class FsUae < Formula
  desc "Amiga emulator"
  homepage "http://fs-uae.net/"

  stable do
    url "http://fs-uae.net/fs-uae/stable/2.6.2/fs-uae-2.6.2.tar.gz"
    sha256 "31328e8da0d31d85ce5ce46830698b83c0ce04dfe6b0f5df6fd3529dba3c0dd4"
  end

  bottle do
    cellar :any
    sha256 "da99ed33136b7933ebf502f6d8c5c27ff3e58e196540ffa58d83c9c3a0d77cf4" => :el_capitan
    sha256 "a37024708147145117bea38119736ad49302fce8a2840f9cc6d37946e4e08673" => :yosemite
    sha256 "6fd5ccb0e18f51578b192ebfd7bbba75d74088b7c7e55645bdc0a4109ae7623b" => :mavericks
  end

  devel do
    url "http://fs-uae.net/fs-uae/devel/2.7.6dev/fs-uae-2.7.6dev.tar.gz"
    version "2.7.6dev"
    sha256 "2a8c9d010e739f4e42c11557b86bf0b30ee3ee9f2bf2289d70799e20ea2be630"
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
