class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.1.1",
                                                :revision => "91e576449fd538e9a0885128b8156a32ad939222"
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    cellar :any
    sha256 "3fb8565a791c9cb833e3d13e2d151b94f11cd3c342efec1f02b66333b53be388" => :el_capitan
    sha256 "423ad210c24560ae00be752d7ab01722ea0f9cacebff907f773e9262b0a07b5e" => :yosemite
    sha256 "174e912494af66a752491f0e78d8ac68b313d1bce2aea20b69b00d44b0038077" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "sdl2"
  depends_on "glew"
  depends_on "snappy"
  depends_on "ffmpeg"

  def install
    args = std_cmake_args
    # Use brewed FFmpeg rather than precompiled binaries in the repo
    args << "-DUSE_SYSTEM_FFMPEG=ON"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      prefix.install "PPSSPPSDL.app"
      bin.write_exec_script "#{prefix}/PPSSPPSDL.app/Contents/MacOS/PPSSPPSDL"
    end
  end
end
