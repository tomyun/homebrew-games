class Supertux < Formula
  desc "Classic 2D jump'n run sidescroller game"
  homepage "http://supertuxproject.org/"
  url "https://github.com/SuperTux/supertux/releases/download/v0.4.0/supertux-0.4.0.tar.bz2"
  sha256 "d18dde3c415e619b4bb035e694ffc384be16576250c9df16929d9ec38daff782"
  revision 1

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
  depends_on "physfs"
  depends_on "glew"

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", "-DDISABLE_CPACK_BUNDLING=ON", *std_cmake_args
    system "make", "install"
    bin.write_exec_script "#{prefix}/SuperTux.app/Contents/MacOS/supertux2"
    (share/"appdata").rmtree
  end

  test do
    assert_equal "supertux2 v#{version}", shell_output("#{bin}/supertux2 --version").chomp
  end
end
