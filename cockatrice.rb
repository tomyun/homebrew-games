class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice.git",
      :tag => "2016-12-31-Release",
      :revision => "f7c8651d51b6aed6b0ea752fff612b9369470800"
  version "2016-12-31"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "1c292441c9c6b920f6fbd4f59499c4538a34055e9d62ac80f27782bbff33791e" => :sierra
    sha256 "a4ff1df9421f2c3f37852c9ce625140ae6fb13c4716841215aa0e9188a47ac5b" => :el_capitan
    sha256 "a7c18ee10956407ec01d26aaad85d4498f1875520ae2980bdaee023144dea426" => :yosemite
  end

  option "with-server", "Build `servatrice` for running game servers"

  depends_on :macos => :mavericks
  depends_on "cmake" => :build
  depends_on "protobuf"

  if build.with? "server"
    depends_on "qt5" => "with-mysql"
  else
    depends_on "qt5"
  end

  fails_with :clang do
    build 503
    cause "Undefined symbols for architecture x86_64: google::protobuf"
  end

  def install
    mkdir "build" do
      args = std_cmake_args
      args << "-DWITH_SERVER=ON" if build.with? "server"
      system "cmake", "..", *args
      system "make", "install"
      prefix.install Dir["release/*.app"]
    end
    doc.install Dir["doc/usermanual/*"]
  end

  test do
    (prefix/"cockatrice.app/Contents/MacOS/cockatrice").executable?
    (prefix/"oracle.app/Contents/MacOS/oracle").executable?
  end
end
