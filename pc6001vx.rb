class Pc6001vx < Formula
  desc "PC-6001 emulator"
  homepage "http://eighttails.seesaa.net/"
  url "http://eighttails.up.seesaa.net/bin/PC6001VX_2.21.0_src.tar.gz"
  sha256 "734f9b5d75c5c3bdba9ed2f33a4de83d5659481f9701fbaac3d9756305602ee9"
  head "https://github.com/eighttails/PC6001VX.git"

  bottle do
    cellar :any
    sha256 "2b42cffbecdd8fd5512eb9aa7949ab0403f7bd67a8ec9dd35a31b56343c5c241" => :el_capitan
    sha256 "4799d2de1daf4f9f880b7a41fa1d75871d17aff99a0b6a64fa0640846eb6131a" => :yosemite
    sha256 "a8c0bbd78a9de00c9ad1cb42cd524146b21842c944e459d57f7bbf95d3b1a645" => :mavericks
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
    # Use libc++ explicitly, otherwise build fails
    ENV.append_to_cflags "-stdlib=libc++" if ENV.compiler == :clang
    system "#{Formula["qt5"].bin}/qmake", "PREFIX=#{prefix}", "QMAKE_CXXFLAGS=#{ENV.cxxflags}", "CONFIG+=c++11"
    system "make"
    prefix.install "PC6001VX.app"
    bin.write_exec_script "#{prefix}/PC6001VX.app/Contents/MacOS/PC6001VX"
  end
end
