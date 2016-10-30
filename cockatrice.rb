class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice.git",
      :tag => "2016-10-30-Release",
      :revision => "3498b16e01093dc21e2b2aaaf10365d13bb5cb1c"
  version "2016-10-30"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    revision 1
    sha256 "9928ada01084b35b9a4bdef522eeae4b5a859f607fe62cc05919e7623a60b921" => :el_capitan
    sha256 "896af772671beede76a8d0a8c781abffb8f393ed2a863f3b73f26fc4b2fddad6" => :yosemite
    sha256 "f742846216b6f421a321c6c09bdc65a86f3a0f8750df843247e30865c553f9c8" => :mavericks
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
