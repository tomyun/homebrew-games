class Gemrb < Formula
  desc "Implementation of Bioware's Inifinity Engine"
  homepage "http://www.gemrb.org/"
  url "https://downloads.sourceforge.net/project/gemrb/GemRB%20Sources/GemRB%200.8.3%20Sources/gemrb-0.8.3.1.tar.gz"
  sha256 "e75cf67ff3f1edfff4dd4219b4f36a0d790b3b63991a84c71a5db6d541cdfd60"
  head "https://github.com/gemrb/gemrb.git"

  depends_on "cmake" => :build
  depends_on :python
  depends_on "sdl2"
  depends_on "sdl2_mixer" => "with-libvorbis"
  depends_on "libvorbis"
  depends_on "freetype"
  depends_on "libpng"

  def install
    ENV.deparallelize

    rm_f "CMakeCache.txt"
    rm_rf "CMakeFiles"
    inreplace "CMakeLists.txt", /(extend2da.py DESTINATION) \${BIN_DIR}/, "\\1 #{bin}"

    mkdir "build" do
      system "cmake", "..",
                      "-DBIN_DIR=#{prefix}",
                      "-DPLUGIN_DIR=#{prefix}/GemRB.app/Contents/PlugIns",
                      "-DLIB_DIR=#{lib}",
                      "-DDATA_DIR=#{prefix}/GemRB.app/Contents/Resources",
                      "-DDOC_DIR=#{doc}",
                      "-DICON_DIR=",
                      "-DSVG_DIR=",
                      "-DMENU_DIR=",
                      "-DUSE_SDL2=1",
                      *std_cmake_args
      system "make", "install"
      contents = "#{prefix}/GemRB.app/Contents"
      bin.write_exec_script "#{contents}/MacOS/GemRB"
      rm_rf "#{contents}/Frameworks"
    end
  end

  test do
    File.executable? "#{prefix}/GemRB.app/Contents/MacOS/GemRB"
  end
end
