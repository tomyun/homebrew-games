class Reminiscence < Formula
  desc "Flashback engine reimplementation"
  homepage "http://cyxdown.free.fr/reminiscence/"
  url "http://cyxdown.free.fr/reminiscence/REminiscence-0.3.2.tar.bz2"
  sha256 "063a1d9bb61a91ffe7de69516e48164a1d4d5d240747968bed4fd292d5df546f"

  depends_on "libmodplug"
  depends_on "sdl2"

  def install
    # REminiscence supports both SDL1 and 2
    # Use SDL2 to have better input support
    inreplace "Makefile", "sdl-config", "sdl2-config"
    system "make"
    bin.install "rs" => "reminiscence"
  end

  test do
    system bin/"reminiscence", "--help"
  end
end
