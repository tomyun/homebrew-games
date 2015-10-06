class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.1.0",
                                                :revision => "5b3a75542723047bab47fb01793d500685831e96"
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    cellar :any
    sha1 "9ec048258882fb2ea2f71661f6ccf4bcd4373ff6" => :yosemite
    sha1 "cfd18d4a6a6d2e07daa74d6a626d9614c6f201c3" => :mavericks
    sha1 "b6f556ce03d30c0c7ab57c21663a929ebdb9e0dd" => :mountain_lion
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
