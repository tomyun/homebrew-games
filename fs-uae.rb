class FsUae < Formula
  desc "Amiga emulator"
  homepage "http://fs-uae.net/"

  stable do
    url "https://fs-uae.net/stable/2.8.0/fs-uae-2.8.0.tar.gz"
    sha256 "45d038125489e1fbc9094d411ba8413d8394f8b3ab8072baba391308ffa47bb3"
  end

  bottle do
    cellar :any
    sha256 "3204920d6a626985b4241331cab489b41b9d15cbfb068e06373b7389a8e613e5" => :el_capitan
    sha256 "8ab012e2af806983f3cc4a17d872c014fc197b405b4407c6c8f1dd8f97db610e" => :yosemite
    sha256 "6651eefe49050d00499121e08e5fc8b076d43361f86f090fb1127842fb3a74d0" => :mavericks
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
