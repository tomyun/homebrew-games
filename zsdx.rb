class Zsdx < Formula
  desc "Zelda Mystery of Solarus DX"
  homepage "http://www.solarus-games.org/games/zelda-mystery-of-solarus-dx/"
  url "https://github.com/christopho/zsdx/archive/zsdx-1.11.0.tar.gz"
  sha256 "05a5d220bbf2439c9da2e71cd9d104240878123fff5bc702e2405d6d0712f0dc"
  head "https://github.com/christopho/zsdx.git"

  depends_on "cmake" => :build
  depends_on "solarus"

  def install
    system "cmake", ".", *std_cmake_args, "-DSOLARUS_INSTALL_DATADIR=#{share}"
    system "make", "install"
  end

  test do
    system Formula["solarus"].bin/"solarus-run", "-help"
    system "/usr/bin/unzip", pkgshare/"data.solarus"
  end
end
