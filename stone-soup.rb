class StoneSoup < Formula
  desc "Dungeon Crawl Stone Soup: a roguelike game"
  homepage "https://crawl.develz.org/"
  url "https://crawl.develz.org/release/stone_soup-0.18.1.tar.xz"
  sha256 "42271f0a6e33a8f87b381786c7070835c9c868cbdbe9f47039ba088b47cce04d"

  bottle do
    sha256 "6c1dd4dcac648cdd428a5d3cfb89c2048a02283bf3ebbc0e2a84a8c2e0d8dcb9" => :el_capitan
    sha256 "3f215690d0275fabcdd7c86ff6fc83fdae952246371be042c7077be34785828c" => :yosemite
    sha256 "814a9a0dbbe82997b8aef0dad6bb5298deebcdff72b61705ffbffece7f5bfe13" => :mavericks
  end

  option "with-tiles", "Enable graphic tiles and sound"

  depends_on "pkg-config" => :build
  depends_on "lua51"
  depends_on "pcre"

  if build.with? "tiles"
    depends_on "sdl2"
    depends_on "sdl2_mixer"
    depends_on "sdl2_image"
    depends_on "libpng"
    depends_on "freetype"
  end

  needs :cxx11

  def install
    ENV.cxx11

    cd "source" do
      args = %W[
        prefix=#{prefix}
        DATADIR=data
        NO_PKGCONFIG=
        BUILD_ZLIB=
        BUILD_LUA=
        BUILD_SQLITE=yes
        BUILD_FREETYPE=
        BUILD_LIBPNG=
        BUILD_SDL2=
        BUILD_SDL2MIXER=
        BUILD_SDL2IMAGE=
        BUILD_PCRE=
        USE_PCRE=y
      ]
      if build.with? "tiles"
        inreplace "Makefile", "contrib/install/$(ARCH)/lib/libSDL2main.a", ""
        args << "TILES=y"
        args << "SOUND=y"
      end

      # FSF GCC doesn't support the -rdynamic flag
      args << "NO_RDYNAMIC=y" unless ENV.compiler == :clang

      # The makefile has trouble locating the developer tools for
      # CLT-only systems, so we set these manually. Reported upstream:
      # https://crawl.develz.org/mantis/view.php?id=7625
      #
      # On 10.9, stone-soup will try to use xcrun and fail due to an empty
      # DEVELOPER_DIR
      devdir = MacOS::Xcode.prefix.to_s
      devdir += "/" if MacOS.version >= :mavericks && !MacOS::Xcode.installed?

      system "make", "install",
        "DEVELOPER_DIR=#{devdir}", "SDKROOT=#{MacOS.sdk_path}",
        # stone-soup tries to use `uname -m` to determine build -arch,
        # which is frequently wrong on OS X
        "SDK_VER=#{MacOS.version}", "MARCH=#{MacOS.preferred_arch}",
        *args
    end
  end

  test do
    assert shell_output("#{bin}/crawl --version").start_with? "Crawl version #{version}"
  end
end
