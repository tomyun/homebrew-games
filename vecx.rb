class Vecx < Formula
  desc "Vectrex emulator"
  homepage "https://github.com/jhawthorn/vecx"
  url "https://github.com/jhawthorn/vecx/archive/v1.0.tar.gz"
  sha256 "6aac0c1840982aa3cc8607d5fa65597b6644840f2ba1ea3715a0349522312f56"

  bottle do
    cellar :any
    sha256 "fe7a6d47ecf1563bc0ba174b8ffc923f0f8d9790cf170fe71ff4a6dae21a2eb2" => :yosemite
    sha256 "48093d359963549ca5bc45865e9823a740cd1a7c5d860f91586c6146c9b4d47f" => :mavericks
    sha256 "9490f5000f3ad756f2205b67f61aaf8cf4181115dd66c0c229a3d3d80a66199b" => :mountain_lion
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
