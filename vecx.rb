class Vecx < Formula
  desc "Vectrex emulator"
  homepage "https://github.com/jhawthorn/vecx"
  url "https://github.com/jhawthorn/vecx/archive/v1.0.tar.gz"
  sha256 "6aac0c1840982aa3cc8607d5fa65597b6644840f2ba1ea3715a0349522312f56"
  revision 1

  bottle do
    cellar :any
    sha256 "7a81afac2ab0b525b371e246304775daa7d434cd399fc00c6b802b4a6cc80633" => :el_capitan
    sha256 "5096e16d1d5a3d28396495bf81fde8eca2a1eb1b534a6b1ffe67acb2df0222ec" => :yosemite
    sha256 "85d465a4c67d097d64edb6fecee37643a0542dcb247e3bdf48e134b2b13f5327" => :mavericks
  end

  head do
    url "https://github.com/jhawthorn/vecx.git"
    depends_on "sdl_image"
  end

  depends_on "sdl"
  depends_on "sdl_gfx"

  def install
    # Fix missing symobls for inline functions
    # https://github.com/jhawthorn/vecx/pull/3
    inreplace ["e6809.c", "vecx.c"], /__inline/, 'static \1'

    system "make"
    bin.install "vecx"
  end
end
