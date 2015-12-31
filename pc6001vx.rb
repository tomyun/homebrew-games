class Pc6001vx < Formula
  desc "PC-6001 emulator"
  homepage "http://eighttails.seesaa.net/"
  url "http://eighttails.up.seesaa.net/bin/PC6001VX_2.11_src.tar.gz"
  sha256 "09c689975b95b48687efc5124c9decb4c64e4cbc9566f9b476b0b81b346f206c"
  head "https://github.com/eighttails/PC6001VX.git"

  bottle do
    cellar :any
    sha256 "6f545abd902bcc35f5f794bf8419a0f718f093aa67ad88c70cf8d9dba9a0e864" => :el_capitan
    sha256 "460fe81d428cd317a12524d4759ed682b08f02a47a6b30bdee1ea6b710f1e091" => :yosemite
    sha256 "56744dfacc45b7a85cb0515f6760ff1b2260a213aaf27577bafd3f9d27e2724c" => :mavericks
  end

  depends_on "qt5"
  depends_on "sdl2"
  depends_on "ffmpeg"

  def install
    # Need to explicitly set up include directories
    ENV.append_to_cflags "-I#{Formula["sdl2"].opt_include}"
    ENV.append_to_cflags "-I#{Formula["ffmpeg"].opt_include}"
    # Turn off errors on C++11 build which used for properly linking standard lib
    ENV.append_to_cflags "-Wno-reserved-user-defined-literal"
    system "#{Formula["qt5"].bin}/qmake", "PREFIX=#{prefix}", "QMAKE_CXXFLAGS=#{ENV.cxxflags}", "CONFIG+=c++11"
    system "make"
    prefix.install "PC6001VX.app"
    bin.write_exec_script "#{prefix}/PC6001VX.app/Contents/MacOS/PC6001VX"
  end
end
