class Supertux < Formula
  desc "Classic 2D jump'n run sidescroller game"
  homepage "https://supertuxproject.org/"
  url "https://github.com/SuperTux/supertux/releases/download/v0.5.0/SuperTux-v0.5.0-Source.tar.gz"
  sha256 "cfae0da40c41532fb414c3b17891c98396b59471fe583a8fc756b96aea61a73b"
  head "https://github.com/SuperTux/supertux.git"

  bottle do
    cellar :any
    sha256 "c649d28231717f8a5fed8d953579920ce7e47e5de4fdbd58bcab9026c006dc13" => :sierra
    sha256 "f4c8c4bc4dbd36d9e76f7e4c4c1ea2c036d85af7d1fc412913b4076e62facf03" => :el_capitan
    sha256 "1a09615247afa6c29ec3bf06fd2dbec5c88075dff8431710c9980fe55dace8c4" => :yosemite
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

  needs :cxx11

  # Fix symlink passing to physfs
  # https://github.com/SuperTux/supertux/issues/614
  patch do
    url "https://github.com/SuperTux/supertux/commit/47a353e2981161e2da12492822fe88d797af2fec.diff"
    sha256 "bb88211eacf76698521b5b85972e2facd93bceab92fa37529ec3ff5482d82956"
  end

  def install
    ENV.cxx11

    args = std_cmake_args
    args << "-DINSTALL_SUBDIR_BIN=bin"
    args << "-DINSTALL_SUBDIR_SHARE=share/supertux"
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
