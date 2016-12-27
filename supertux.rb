class Supertux < Formula
  desc "Classic 2D jump'n run sidescroller game"
  homepage "https://supertuxproject.org/"
  url "https://github.com/SuperTux/supertux/releases/download/v0.5.1/SuperTux-v0.5.1-Source.tar.gz"
  sha256 "c9dc3b42991ce5c5d0d0cb94e44c4ec2373ad09029940f0e92331e7e9ada0ac5"
  head "https://github.com/SuperTux/supertux.git"

  bottle do
    cellar :any
    sha256 "828ec18e4f0efbe7e8c12ca97eab0b201c3c6dbac97c3f1494aab151ef07292f" => :sierra
    sha256 "2f9ec0654104c9fa3efe0b8155afb66cb2e659dea4dd4396ed8ea53aaf2ba996" => :el_capitan
    sha256 "796a98d6295e95d53d9ee406c58fbbeb58ceb8554b69d03f27be54777469d9ca" => :yosemite
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "boost" => :build
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer" => "with-libvorbis"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "glew"

  # Fix symlink passing to physfs
  # https://github.com/SuperTux/supertux/issues/614
  patch do
    url "https://github.com/SuperTux/supertux/commit/47a353e2981161e2da12492822fe88d797af2fec.diff"
    sha256 "bb88211eacf76698521b5b85972e2facd93bceab92fa37529ec3ff5482d82956"
  end

  needs :cxx11

  def install
    ENV.cxx11

    args = std_cmake_args
    args << "-DINSTALL_SUBDIR_BIN=bin"
    args << "-DINSTALL_SUBDIR_SHARE=share/supertux"
    # Without the following option, Cmake intend to use the library of MONO framework.
    args << "-DPNG_PNG_INCLUDE_DIR=#{Formula["libpng"].opt_include}"
    system "cmake", ".", *args
    system "make", "install"

    # Remove unnecessary files
    (share/"appdata").rmtree
    (share/"applications").rmtree
    (share/"pixmaps").rmtree
    (prefix/"MacOS").rmtree
  end

  test do
    assert_equal "supertux2 v#{version}", shell_output("#{bin}/supertux2 --version").chomp
  end
end
