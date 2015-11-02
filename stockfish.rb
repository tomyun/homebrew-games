class Stockfish < Formula
  desc "Strong open-source chess engine"
  homepage "http://stockfishchess.org/"
  url "http://stockfish.s3.amazonaws.com/stockfish-6-src.zip"
  sha256 "a69a371d3f84338cefde4575669bd930d186b046a10fa5ab0f8d1aed6cb204c3"
  head "https://github.com/official-stockfish/Stockfish.git"

  bottle do
    cellar :any
    sha256 "622bacb36395cb7ccdb83510c354292d954aa655201fdc506185de99b18de75d" => :yosemite
    sha256 "f02a0eaa017869d57cdb713ab8e20c70122ed17fa60f8add1f2db1933b843ec2" => :mavericks
    sha256 "6dda7191589eb57f3145681eeb6868dc528d0a3ccd217213177378c57f6a3873" => :mountain_lion
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
