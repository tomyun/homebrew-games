class Pc6001vx < Formula
  desc "PC-6001 emulator"
  homepage "http://eighttails.seesaa.net/"
  url "http://eighttails.up.seesaa.net/bin/PC6001VX_2.30.0_src.tar.gz"
  sha256 "51347ba79b05c66fe029cfc430ba2a4661b61d25ec3b03bc405b52a2fac97021"
  head "https://github.com/eighttails/PC6001VX.git"

  bottle do
    cellar :any
    sha256 "bb7696068bfe6f2b5c0319801982475169641a8b3571f6d5ce113575174560c1" => :el_capitan
    sha256 "b86e0f9c510382f483c317c7a9aacd98bc3ef4ead417a452894a67de17b79c77" => :yosemite
    sha256 "2d6e55fd3e3339860a4223770938285a2c52f254e3b195de5391e4b683fc5dd2" => :mavericks
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
