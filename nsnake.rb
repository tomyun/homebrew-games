class Nsnake < Formula
  desc "Classic snake game with textual interface"
  homepage "http://nsnake.alexdantas.net/"
  url "https://downloads.sourceforge.net/project/nsnake/GNU-Linux/nsnake-3.0.1.tar.gz"
  sha256 "e0a39e0e188a6a8502cb9fc05de3fa83dd4d61072c5b93a182136d1bccd39bb9"
  head "https://github.com/alexdantas/nSnake.git"

  def install
    system "make", "install", "PREFIX=#{prefix}"

    # No need for Linux desktop
    (share/"applications").rmtree
    (share/"icons").rmtree
    (share/"pixmaps").rmtree
  end

  test do
    assert_match /nsnake v#{version} /, shell_output("#{bin}/nsnake -v")
  end
end
