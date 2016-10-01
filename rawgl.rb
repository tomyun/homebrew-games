class Rawgl < Formula
  desc "Rewritten engine for Another World"
  homepage "http://cyxdown.free.fr/rawgl/"
  url "https://github.com/cyxx/rawgl/archive/rawgl-0.2.1.tar.gz"
  sha256 "da00d4abbc266e94c3755c2fd214953c48698826011b1d4afbebb99396240073"
  head "https://github.com/cyxx/rawgl.git"

  depends_on "sdl2"
  depends_on "sdl2_mixer"

  def install
    system "make"
    bin.install "rawgl"
  end

  test do
    system bin/"rawgl", "--help"
  end
end
