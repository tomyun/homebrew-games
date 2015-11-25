class Bastet < Formula
  desc "Bastard Tetris"
  homepage "http://fph.altervista.org/prog/bastet.html"
  url "https://github.com/fph/bastet/archive/0.43.1.tar.gz"
  sha256 "c47a84fb17c2895ea7a85b72ea40a154a03c1114c178ea7fee341215153afcdc"

  bottle do
    cellar :any
    sha256 "2b8b98b85c99146690f363dc780d946c8fe8cecfb838ab3fb0dbad8614b83bc5" => :yosemite
    sha256 "c246613779b82dac07649d5d53b846f38ffababa8d7ec40e405e0cc91a046686" => :mavericks
    sha256 "cf39c88f44e2786e109e3d87bc2da1e954ae70245d452a938e66115f77576e68" => :mountain_lion
  end

  # "friend declaration specifying a default argument must be a definition"
  patch do
    url "https://github.com/fph/bastet/commit/0323cb477dd5293b5198e4b2f47b4441d90de2d8.patch"
    sha256 "244884bed959a13e14560041f0493dc6f39727a5c8da1656b7b83e16cb8be667"
  end

  patch do
    url "https://github.com/fph/bastet/commit/968324901dae2c80bdbdb40eca1b514498380ba8.patch"
    sha256 "f68bd3aa62e4b861b869aca1125f91f90493b6c331a7850bc7b7f3a19989e1ed"
  end

  depends_on "boost"

  def install
    inreplace %w[Config.cpp bastet.6], "/var", var

    system "make", "all"

    # this must exist for games to be saved globally
    (var/"games").mkpath
    touch "#{var}/games/bastet.scores2"

    bin.install "bastet"
    man6.install "bastet.6"
  end
end
