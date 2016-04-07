class Onscripter < Formula
  desc "NScripter-compatible visual novel engine"
  homepage "https://onscripter.osdn.jp/"
  url "https://onscripter.osdn.jp/onscripter-20160407.tar.gz"
  sha256 "5db848ff0c477659389b29c56b331f8a1ec0a89cc8cd3de8ab847efc27bc9ad3"

  bottle do
    cellar :any
    sha256 "50a02494f81245f08790575a4d8f3dd281dba4e3d5c4640edeed34db73d1b4b2" => :el_capitan
    sha256 "0bd6ba2eef964f8c1a173df0cb2984685d008f20356554a3f19e153345168f6e" => :yosemite
    sha256 "54c0a268fe8e3351e39e34f5cb6a2ecbebb803aeb639199a7d148e7c84415704" => :mavericks
  end

  option "with-english", "Build with single-byte character mode"

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "sdl_ttf"
  depends_on "sdl_image"
  depends_on "sdl_mixer" => "with-libvorbis"
  depends_on "smpeg"
  depends_on "jpeg"
  depends_on "lua" => :recommended

  def install
    incs = [
      `pkg-config --cflags sdl SDL_ttf SDL_image SDL_mixer`.chomp,
      `smpeg-config --cflags`.chomp,
      "-I#{Formula["jpeg"].include}",
    ]

    libs = [
      `pkg-config --libs sdl SDL_ttf SDL_image SDL_mixer`.chomp,
      `smpeg-config --libs`.chomp,
      "-ljpeg",
      "-lbz2",
    ]

    defs = %w[
      -DMACOSX
      -DUSE_CDROM
      -DUTF8_CAPTION
      -DUTF8_FILESYSTEM
    ]

    ext_objs = []

    if build.with? "lua"
      lua = Formula["lua"]
      incs << "-I#{lua.include}"
      libs << "-L#{lua.lib} -llua"
      defs << "-DUSE_LUA"
      ext_objs << "LUAHandler.o"
    end

    if build.with? "english"
      defs += %w[
        -DENABLE_1BYTE_CHAR
        -DFORCE_1BYTE_CHAR
      ]
    end

    k = %w[INCS LIBS DEFS EXT_OBJS]
    v = [incs, libs, defs, ext_objs].map { |x| x.join(" ") }
    args = k.zip(v).map { |x| x.join("=") }
    system "make", "-f", "Makefile.MacOSX", *args
    bin.install %w[onscripter sardec nsadec sarconv nsaconv]
  end

  test do
    system "#{bin}/onscripter", "-v"
  end
end
