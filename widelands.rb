class Widelands < Formula
  desc "Free real-time strategy game like Settlers II."
  homepage "https://wl.widelands.org/"
  url "https://launchpad.net/widelands/build19/build19/+download/widelands-build19-src.tar.bz2"
  sha256 "e511f9d26828a2b71b64cdfc6674e6e847543b2da73961ab882acca36c7c01a6"

  bottle do
    cellar :any
    sha256 "37a4e3d7eeb33a963f8ed568abe488df666385d5d8514fda4403dfc5939882c1" => :el_capitan
    sha256 "da07952c61c3ff0a67eeb534754203e75cb31639d0335d30a28a3d17d908cd6f" => :yosemite
    sha256 "618b7837413b5eb81be71f6db038e11e9c30436aee5450dcc167bd60e966e15c" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libpng"
  depends_on "minizip"
  depends_on "gettext"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"
  depends_on "sdl2_net"
  depends_on "sdl2_ttf"
  depends_on "doxygen"
  depends_on "glew"
  depends_on "lua"
  depends_on "icu4c"

  needs :cxx11

  def install
    ENV.cxx11
    mkdir "build" do
      system "cmake", "..",
                      # Without the following option, Cmake intend to use the library of MONO framework.
                      "-DPNG_PNG_INCLUDE_DIR:PATH=#{Formula["libpng"].opt_include}",
                      "-DWL_INSTALL_DATADIR=#{pkgshare}/data",
                       *std_cmake_args
      system "make", "install"

      (bin/"widelands").write <<-EOS.undent
        #!/bin/sh
        exec #{prefix}/widelands "$@"
      EOS
    end
  end

  test do
    system bin/"widelands", "--version"
  end
end
