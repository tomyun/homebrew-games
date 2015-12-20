class Supertux < Formula
  desc "Classic 2D jump'n run sidescroller game"
  homepage "http://supertuxproject.org/"
  url "https://github.com/SuperTux/supertux/releases/download/v0.4.0/supertux-0.4.0.tar.bz2"
  sha256 "d18dde3c415e619b4bb035e694ffc384be16576250c9df16929d9ec38daff782"

  bottle do
    sha256 "5dce574690fa4f983731166849a339a6afbce201bd4abef609ea986297e2b495" => :el_capitan
    sha256 "bb4a521d8d992934a68fe6227091f42e100546b20499ec12aba65edf6d2cd962" => :yosemite
    sha256 "f3fde4a559bd5d3edbd9af221f89322f2d3a83c67ef998dcabc0aea42ab9fe83" => :mavericks
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
