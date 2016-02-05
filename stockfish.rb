class Stockfish < Formula
  desc "Strong open-source chess engine"
  homepage "http://stockfishchess.org/"
  url "https://stockfish.s3.amazonaws.com/stockfish-7-src.zip"
  sha256 "89f1bb855c9251c1c644156d82960c71aa68e837390367f5111aa756e0785f36"
  head "https://github.com/official-stockfish/Stockfish.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "f05f74604a569a622f50e2750c37c24afd5177d4523797dc25120cbdbb5243fa" => :el_capitan
    sha256 "b473374b47d14bf9ef7ad173f61851622361e68779257cdde5ef747fe34896ef" => :yosemite
    sha256 "091dbe159b21e95a4c5f1aaba64390ae4478c694462a203719df6e1ac3f5505e" => :mavericks
  end

  def install
    if Hardware::CPU.features.include? :popcnt
      arch = "x86-64-modern"
    else
      arch = Hardware::CPU.ppc? ? "ppc" : "x86"
      arch += "-" + (MacOS.prefer_64_bit? ? "64" : "32")
    end

    system "make", "-C", "src", "build", "ARCH=#{arch}"
    bin.install "src/stockfish"
  end

  test do
    system "#{bin}/stockfish", "go", "depth", "20"
  end
end
