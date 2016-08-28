class Mapcrafter < Formula
  desc "Minecraft map renderer"
  homepage "http://mapcrafter.org"
  url "https://github.com/mapcrafter/mapcrafter/archive/v.2.3.1.tar.gz"
  sha256 "b88e53ccffc00f83717f2e686dbed047b95f011187af2b7a23ba7f5cd3537679"

  bottle do
    cellar :any
    sha256 "b50819f741e29cc54d1c09d361f0311c7b40f4619f6ebfb7b4119e29958a0a97" => :el_capitan
    sha256 "ce2979a74e7c56906867df248577e82d8cf45274385c61393f646bf1c5bc7ac7" => :yosemite
    sha256 "7136bb5b641e1a9675339f8d8ee6d4c9c4b2c635f3e7d02720fdc5e3c7d89851" => :mavericks
  end

  needs :cxx11

  depends_on "cmake" => :build
  depends_on "jpeg-turbo"
  depends_on "libpng"

  if MacOS.version < :mavericks
    depends_on "boost" => "c++11"
  else
    depends_on "boost"
  end

  def install
    ENV.cxx11

    args = std_cmake_args
    args << "-DJPEG_INCLUDE_DIR=#{Formula["jpeg-turbo"].opt_include}"
    args << "-DJPEG_LIBRARY=#{Formula["jpeg-turbo"].opt_lib}/libjpeg.dylib"

    system "cmake", ".", *args
    system "make", "install"
  end

  test do
    assert_match(/Mapcrafter/,
      shell_output("#{bin}/mapcrafter --version"))
  end
end
