class Onscripter < Formula
  desc "NScripter-compatible visual novel engine"
  homepage "https://onscripter.osdn.jp/"
  url "https://onscripter.osdn.jp/onscripter-20161025.tar.gz"
  sha256 "2d1b71b8aed25f876d57df8e0cfd773e0e9c465f373a9b9900d3c4a931cf73d6"

  bottle do
    cellar :any
    sha256 "9bbc625b301bd0d0ed854e85f1fc708108d5efdf8bdee459a6c5e7a65487b87d" => :sierra
    sha256 "bc341879786e076c9ab70175fc957aeac1b9441a1dcd6f9abf6bb5b74753ba91" => :el_capitan
    sha256 "a239f5a5bdbce10ea701c89f897d62bed4efdd8ef5bc8138666851a78becc065" => :yosemite
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
    assert shell_output("#{bin}/onscripter -v").start_with? "ONScripter version #{version}"
  end
end
