class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160112.tar.gz"
  sha256 "619a1f7c4ee1f54189d36150a930a8975ab990912e1481905f26a409dea30813"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "7b62f8898bde74a6876272b1059a93262a2d916aa51e250c297efe1d0832bc0a" => :el_capitan
    sha256 "caa9792a3eccf916e530ba91b304e55560b5b311bdaa09c895483bdddd328f4e" => :yosemite
    sha256 "9ccf773e33b3fdee5b2499742ebe3ae6a5b497a4ebb3404b1652f9c0dfc7c5ce" => :mavericks
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "assimp"
  depends_on "freetype"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "libsigc++"
  depends_on "libvorbis"
  depends_on "libpng"
  depends_on "lua"

  needs :cxx11

  def install
    ENV.cxx11
    ENV["PIONEER_DATA_DIR"] = "#{pkgshare}/data"
    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-version=#{version}",
                          "--with-external-liblua"
    system "make", "install"
  end

  test do
    assert_equal "#{name} #{version}", shell_output("#{bin}/pioneer -v 2>&1").chomp
  end
end
