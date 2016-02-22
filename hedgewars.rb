require "language/haskell"

class Hedgewars < Formula
  include Language::Haskell::Cabal

  desc "Turn-based strategy/artillery/action and comedy game"
  homepage "http://www.hedgewars.org"
  url "http://download.gna.org/hedgewars/hedgewars-src-0.9.22.tar.bz2"
  sha256 "b699c8971ff420c3edd6533527ae2e99040f1e79207c9140826945bcf0e62192"
  head "https://code.google.com/p/hedgewars/", :using => :hg

  bottle do
    cellar :any
    revision 1
    sha256 "f22a0bc05f83ee16155ba3a6a46ad543afefefde39397b069e887eeea22703c6" => :el_capitan
    sha256 "f13e497b31f9d0e02f6ea3f1da2c3b84c6f7b4f5cc1f7e26bb6cc4e085819cec" => :yosemite
    sha256 "32086ae22b80ee9bc661444628741df41c47a326ad17104978e991da8b1cfa73" => :mavericks
  end

  option "with-server", "Enable local LAN play"
  option "with-videorec", "Enable video recording"

  depends_on "cmake" => :build
  depends_on "fpc" => :build
  depends_on "qt"
  depends_on "physfs"
  depends_on "libpng"
  depends_on "lua51"
  depends_on "sdl"
  depends_on "sdl_image"
  depends_on "sdl_net"
  depends_on "sdl_mixer" => "with-libvorbis"
  depends_on "sdl_ttf"
  depends_on "ffmpeg" if build.with? "videorec"

  if build.with? "server"
    depends_on "ghc" => :build
    depends_on "cabal-install" => :build
    depends_on "gmp"
    setup_ghc_compilers
  end

  def install
    # rely on homebrew update, packaging, and source system
    args = %w[-DNOAUTOUPDATE=1 -DSKIPBUNDLE=1 -DPHYSFS_SYSTEM=1 -DLUA_SYSTEM=1]

    args << "-DGL2=1" if build.with? "gl2"
    args << "-DNOSERVER=1" if build.without? "server"
    args << "-DNOVIDEOREC=1" if build.without? "videorec"
    args << "-DCMAKE_BUILD_TYPE=Debug" if build.head?

    # this will prepare all server dependencies
    if build.with? "server"
      cabal_sandbox do
        cabal_install "--only-dependencies", "gameServer/hedgewars-server.cabal"
      end
      cabal_clean_lib
    end
    system "cmake", ".", *(std_cmake_args + args)
    system "make", "install"
    prefix.install "Hedgewars.app"
  end

  test do
    system prefix/"Hedgewars.app/Contents/MacOS/hedgewars", "--help"
  end
end
