class Gemrb < Formula
  desc "Implementation of Bioware's Inifinity Engine"
  homepage "http://www.gemrb.org/"
  url "https://downloads.sourceforge.net/project/gemrb/GemRB%20Sources/GemRB%200.8.4%20Sources/gemrb-0.8.4.tar.gz"
  sha256 "641a02179655bbadea4a806e9af12349b42fc528596efd5a2ff5cb6d213f1d69"
  head "https://github.com/gemrb/gemrb.git"

  depends_on "cmake" => :build
  depends_on :python
  depends_on "freetype"
  depends_on "glew"
  depends_on "libvorbis"
  depends_on "libpng"
  depends_on "sdl2"

  def install
    ENV.deparallelize

    inreplace "CMakeLists.txt", /(extend2da.py DESTINATION) \${BIN_DIR}/, "\\1 #{bin}"

    mkdir "build" do
      contents = "#{prefix}/GemRB.app/Contents"
      system "cmake", "..",
                      "-DBIN_DIR=#{prefix}",
                      "-DLIB_DIR=#{contents}/Frameworks",
                      "-DPLUGIN_DIR=#{contents}/PlugIns",
                      "-DDATA_DIR=#{contents}/Resources",
                      "-DDOC_DIR=#{doc}",
                      *std_cmake_args
      system "make", "install"
      contents = "#{prefix}/GemRB.app/Contents"
      bin.write_exec_script "#{contents}/MacOS/GemRB"
    end
  end
end
