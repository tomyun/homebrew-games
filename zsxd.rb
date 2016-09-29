class Zsxd < Formula
  desc "Zelda Mystery of Solarus XD"
  homepage "http://www.solarus-games.org/games/zelda-mystery-of-solarus-xd/"
  url "https://github.com/christopho/zsxd/archive/zsxd-1.11.0.tar.gz"
  sha256 "4c6e744ecc5b7e123f5e085ed993e8234cbef8046d2717d16121a2b711e0ccde"
  head "https://github.com/christopho/zsxd.git"

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
