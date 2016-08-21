class Ppsspp < Formula
  desc "PlayStation Portable emulator"
  homepage "http://ppsspp.org/"
  url "https://github.com/hrydgard/ppsspp.git", :tag => "v1.2.2",
                                                :revision => "8c9f3b9509e8a6850e086ec36a59ca7fa4082d60"
  revision 1
  head "https://github.com/hrydgard/ppsspp.git"

  bottle do
    cellar :any
    sha256 "5f6c338fc9e44d3014b6efe1a372ef5a8c0183403a2ee48cd93b4c008bfd1ead" => :el_capitan
    sha256 "3cc541e4290ab12ba3c440b3e0a832fecfb7255c767207bcd0c49766772745db" => :yosemite
    sha256 "39222e42072b24faef94352ae240671d6d5a829e6bbba51acaff0fe1696be2f4" => :mavericks
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
