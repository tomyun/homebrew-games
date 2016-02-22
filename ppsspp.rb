class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.2.1",
                                                :revision => "52eca3d2116b4a18428e7abac11c09f969dd7a60"
  revision 1
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    cellar :any
    sha256 "aec874d7728c4e771e228ed91b3bf168658fc0a3e0cdf6f371a8f5d115dc279d" => :el_capitan
    sha256 "c2fb79160540a2476a5d620a88b2043a9910016ab6c407c716428428051bf45b" => :yosemite
    sha256 "15699e26ebf69eedd7e0f36793428a07d99219c45e6190a489e1caddb5e59b52" => :mavericks
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
