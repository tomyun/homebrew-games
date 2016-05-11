class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice/archive/2016-05-06-Release.tar.gz"
  version "2016-05-06"
  sha256 "379835006f38b603af01cf46d508fd40e862b451045807b444042914e8736fee"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "234e5ed711477c567b1cc0c3d7d76020440e67d13629d5881ab9a361c4918f8f" => :el_capitan
    sha256 "7a8406eb4000e3e19a792cb5a240bb4112e6d0e1fc22ff38ca28c78c82de0cb3" => :yosemite
    sha256 "29d06f857a0a573778900c8f566b53d0ccb80c9843ffb3d1c8c4e10f326e209a" => :mavericks
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
