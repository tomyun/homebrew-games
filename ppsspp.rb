class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git",
      tag: "v1.3",
      revision: "6d0d36bf914a3f5373627a362d65facdcfbbfe5f"
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    cellar :any
    sha256 "f71cc9ada5917ba7b12bdda6c79136520984f44f98bd36ce756dc9cbd381bb5f" => :el_capitan
    sha256 "df02f7a457af336680a7f2ec6bcb595769a794ffe870dc62b23d47d8085efd52" => :yosemite
    sha256 "1f2395dc2e3ca68cb759a2db8ea20d9be0a7f28301c445cfc5eda41ecf220c8d" => :mavericks
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
