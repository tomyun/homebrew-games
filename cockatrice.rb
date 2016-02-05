class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice/archive/2016-02-03-Release.tar.gz"
  version "2016-02-03"
  sha256 "eb5ae01422b92cf8461c0f2e4540820f1120c8b0cbfafc4044ad0290a3ef3381"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "73c92b46b63efe16487807adf883469cf671577ec74e70379f20d4ab3c421668" => :el_capitan
    sha256 "2ada5d818fa5317dfe0167588882a868a5b3b39a38bc50ccbf622760628ea5d8" => :yosemite
    sha256 "308fea55479f418d717d3716b34dc1e98c83f33f7ee93b48537189d3501a2d16" => :mavericks
  end

  option "with-server", "Build `servatrice` for running game servers"

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
