class Mapcrafter < Formula
  desc "Minecraft map renderer"
  homepage "http://mapcrafter.org"
  url "https://github.com/mapcrafter/mapcrafter/archive/v.1.5.4.tar.gz"
  sha256 "3701de840e565e347c6f2487dfa29722f801a0ca83d17e1b8cf0c3584f9d7511"

  bottle do
    cellar :any
    sha1 "ac8fd25b80cb3afda8e6efbdbea1a6d09a010771" => :yosemite
    sha1 "23a458a7763f44d020ff5a5ef97152455573c607" => :mavericks
    sha1 "a50194903b88e00f4550996c83f1c083dbaf2689" => :mountain_lion
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
