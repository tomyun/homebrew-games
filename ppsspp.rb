class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.2",
                                                :revision => "951c79f6c3d0fc2122c7f995255aec345ae9ddf0"
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    cellar :any
    sha256 "35d57732c2000ba002b562cbfe4b3711dda6fa8f86fef5fc5aca2b0304958c47" => :el_capitan
    sha256 "51b1ad7e5d03072badad6c70c27a5c646cf5323480b01b196c395970e1908f9e" => :yosemite
    sha256 "d2acf3c5b78c1974a0f381ed46b5f7fee270bb4a69bf66cb8c13f9facbffd7a4" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "sdl2"
  depends_on "glew"
  depends_on "libzip"
  depends_on "snappy"
  depends_on "ffmpeg"

  def install
    args = std_cmake_args
    # Use brewed FFmpeg rather than precompiled binaries in the repo
    args << "-DUSE_SYSTEM_FFMPEG=ON"

    # fix missing include for zipconf.h
    ENV.append_to_cflags "-I#{Formula["libzip"].opt_prefix}/lib/libzip/include"

    mkdir "build" do
      system "cmake", "..", *args
      system "make"
      prefix.install "PPSSPPSDL.app"
      bin.write_exec_script "#{prefix}/PPSSPPSDL.app/Contents/MacOS/PPSSPPSDL"
      mv "#{bin}/PPSSPPSDL", "#{bin}/ppsspp"
    end
  end
end
