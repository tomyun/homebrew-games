class Supertux < Formula
  desc "Classic 2D jump'n run sidescroller game"
  homepage "https://supertuxproject.org/"
  url "https://github.com/SuperTux/supertux/releases/download/v0.5.0/SuperTux-v0.5.0-Source.tar.gz"
  sha256 "cfae0da40c41532fb414c3b17891c98396b59471fe583a8fc756b96aea61a73b"
  head "https://github.com/SuperTux/supertux.git"

  bottle do
    cellar :any
    sha256 "e2d301fee0bd9af3cccb5508ba44d9241cda9b1299beca3432aabb7c23d3e29a" => :el_capitan
    sha256 "2e39b889e73b3db9050d0572d79a4adee72712a7b62588e6086018dbc3199d8b" => :yosemite
    sha256 "55e68af40dd7e80e255ce1c7ce9b2999b6cb271a85a029c16c5015be9e2b3e59" => :mavericks
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
