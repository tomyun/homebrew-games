class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice/archive/2016-05-06-Release.tar.gz"
  version "2016-05-06"
  sha256 "379835006f38b603af01cf46d508fd40e862b451045807b444042914e8736fee"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "4287fa52e3fc3438c59a491dd22a8f91adcbe7ce649df40c5d5a007f18128ecb" => :el_capitan
    sha256 "6f50dab7bf257579d82f75b05e6cb391b04c4b6206b8abbf88c4eed7dec4f481" => :yosemite
    sha256 "75a1f17727714a7faee3c1e363167cb9f730dce0e51a24f6938cf22d0c4f4abd" => :mavericks
  end

  option "with-server", "Build `servatrice` for running game servers"

  depends_on :macos => :mavericks
  depends_on "cmake" => :build
  depends_on "protobuf"

  if build.with? "server"
    depends_on "libgcrypt"
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
