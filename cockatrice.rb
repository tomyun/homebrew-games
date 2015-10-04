class Cockatrice < Formula
  desc "Virtual tabletop for multiplayer card games"
  homepage "https://github.com/Cockatrice/Cockatrice"
  url "https://github.com/Cockatrice/Cockatrice/archive/2015-09-24-Release.tar.gz"
  version "2015-09-24"
  sha256 "ee735be60fbf215c2addcc3cd386fbd68632abdb02fa086aab8cbc35e6480e19"
  head "https://github.com/Cockatrice/Cockatrice.git"

  bottle do
    sha256 "d50ca57225aa3d9740e68d98d93c012a9974d8655a5ad2f66bac7b884b26022a" => :yosemite
    sha256 "055aa2603b67c3283470af2529110ff94bc51a3f08191ea530c2d8899d3ba14e" => :mavericks
    sha256 "126c858e2ea2a1af32241f0982c4e9bf91cefcc0748257be3f0134c5c2e945aa" => :mountain_lion
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
