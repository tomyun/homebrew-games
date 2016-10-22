class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20161022.tar.gz"
  sha256 "072e10cb2ce71fd8412c52027522d6c8ab5736daee4c215aa858da85cfbdc3de"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "f581c8565bad6f5c42389d62efe7cf892e416e760eeb1796655f5bd670995093" => :sierra
    sha256 "2e85d304db555a4854c12ed7965184f9662f1ce470eecc47c05032dcd7514ef4" => :el_capitan
    sha256 "c474792901016383f48e2710b8af4fac017b7e9e181a267e9844214dae07d1a8" => :yosemite
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

    # Remove as soon as possible
    # https://github.com/pioneerspacesim/pioneer/issues/3839
    ENV["ARFLAGS"] = "cru"

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
    assert_equal "modelcompiler #{version}", shell_output("#{bin}/modelcompiler -v 2>&1").chomp
  end
end
