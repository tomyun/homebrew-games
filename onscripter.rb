class Onscripter < Formula
  desc "NScripter-compatible visual novel engine"
  homepage "https://onscripter.osdn.jp/"
  url "https://onscripter.osdn.jp/onscripter-20160327.tar.gz"
  sha256 "1a852515feda20eee2447dd737478d86b90d99591d415bbffe9152f18acfd47e"

  bottle do
    cellar :any
    sha256 "157013c402b34abe7f3946257c6ed795dcedfd69eadf5869cb0ab6b515da29da" => :yosemite
    sha256 "1b5c4779bf1cefc03f7c72560ea6b606e7c34f3421765fc01ea2b8066be9030c" => :mavericks
    sha256 "774be4947bafff89015db83a1104715e7d6008a4613f17c251183649e24f866e" => :mountain_lion
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
