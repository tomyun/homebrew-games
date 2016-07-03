class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice/archive/2016-06-30-Release.tar.gz"
  version "2016-06-30"
  sha256 "18c7ec245be8600d4c4be5868b71238ec669a38a24053d84aed608dae888a6f5"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "ece8a49fbe4d366bd0d7a7ee2d6a98447885883e0a0531d5734e65ab735545ea" => :el_capitan
    sha256 "ad0f95bf12cfc79371f80992e6065d4973e0957be8637fbc1ec1ae6a83373665" => :yosemite
    sha256 "6b7c516c212b2611c4bedd7836edeb663281bc197169b218d1c1a54b9ad5fda0" => :mavericks
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
