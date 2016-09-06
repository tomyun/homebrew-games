class FsUae < Formula
  desc "Amiga emulator"
  homepage "http://fs-uae.net/"
  revision 1

  stable do
    url "http://fs-uae.net/fs-uae/stable/2.6.2/fs-uae-2.6.2.tar.gz"
    sha256 "31328e8da0d31d85ce5ce46830698b83c0ce04dfe6b0f5df6fd3529dba3c0dd4"
  end

  bottle do
    cellar :any
    sha256 "3204920d6a626985b4241331cab489b41b9d15cbfb068e06373b7389a8e613e5" => :el_capitan
    sha256 "8ab012e2af806983f3cc4a17d872c014fc197b405b4407c6c8f1dd8f97db610e" => :yosemite
    sha256 "6651eefe49050d00499121e08e5fc8b076d43361f86f090fb1127842fb3a74d0" => :mavericks
  end

  devel do
    url "http://fs-uae.net/fs-uae/devel/2.7.14dev/fs-uae-2.7.14dev.tar.gz"
    version "2.7.14dev"
    sha256 "9df7445bccef5255a66135f040dfbcac48b20df79f09daced166c8771428da83"
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
