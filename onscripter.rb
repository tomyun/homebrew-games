class Onscripter < Formula
  desc "NScripter-compatible visual novel engine"
  homepage "https://onscripter.osdn.jp/"
  url "https://onscripter.osdn.jp/onscripter-20160920.tar.gz"
  sha256 "55802e563afe8a29e5e20e31515435adb84ac56a05537669df56b04170e60f19"

  bottle do
    cellar :any
    sha256 "7d4b8be01d2bae578c0edbdd6e8c4bd66be953ca8f624b3384639ade0453128a" => :el_capitan
    sha256 "49fa1a288c7c1b12297653a6a3fa0c2b9edce6b37754595843a79777563ec8d4" => :yosemite
    sha256 "16fff5f13145a607acbea78a5f8c1a60e7fdead1d66bd4a1dabc7a8d048e2fec" => :mavericks
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
