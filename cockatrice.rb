class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice.git",
      :tag => "2017-01-20-Release",
      :revision => "dab731656dd5856ca293e2660e142cc215acc66e"
  version "2017-01-20"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "ea0101ff11ef1510887897a772439024a40bcd8a6cc01982787964b7042e5d1b" => :sierra
    sha256 "8985f02226c4b35f0cde8cfd390053de1d9e86b5883aa084cb3a08f4fc3d627e" => :el_capitan
    sha256 "09d76a7bebcee01024f2467d44f5b51cf6a9d84fbdf1f2469a8d0be9ea11c1c8" => :yosemite
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
