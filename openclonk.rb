class Openclonk < Formula
  desc "Multiplayer action game"
  homepage "http://www.openclonk.org"
  url "http://www.openclonk.org/builds/release/7.0/openclonk-7.0-src.tar.bz2"
  sha256 "bc1a231d72774a7aa8819e54e1f79be27a21b579fb057609398f2aa5700b0732"
  head "https://github.com/openclonk/openclonk", :using => :git

  bottle do
    cellar :any
    sha256 "bab95c703bf739aa824087a2d7e74e6cb2ba39820d5579b4b844b278ed2ce312" => :yosemite
    sha256 "78db1e1d29ff023e2bdf2c9a1e1cbee9793664c4ec42f9a6c2f017580c7a5ceb" => :mavericks
    sha256 "522ebcef7cc4a6597f7593b976827b0409612f483e48df4876294e0de40a8119" => :mountain_lion
  end

  # Requires some C++14 features missing in Mavericks
  depends_on :macos => :yosemite
  depends_on "cmake" => :build
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "freetype"
  depends_on "glew"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "boost"
  depends_on "freealut"

  needs :cxx11

  def install
    ENV.cxx11
    system "cmake", ".", *std_cmake_args
    system "make"
    system "make", "install"
    bin.write_exec_script "#{prefix}/openclonk.app/Contents/MacOS/openclonk"
    bin.install Dir[prefix/"c4*"]
  end

  test do
    system bin/"c4group"
  end
end
