class Colem < Formula
  desc "ColecoVision emulator"
  homepage "http://fms.komkon.org/ColEm/"
  url "http://fms.komkon.org/ColEm/ColEm37-Source.zip"
  version "3.7"
  sha256 "e3679108dd4f9ad05df7e763319cedc38000337443d3f7a6ff5d89a40e795e08"

  bottle do
    cellar :any
    sha256 "c1da46185a0ee2160a2d53ccf19606b26e33e816d5e207e3a2883876c2c4dda6" => :el_capitan
    sha256 "e911bfd042c45372b8a1dd534bcdd3c80fc50bd050fc675a055588603f6636a4" => :yosemite
    sha256 "cb008ad2626e42d08c4128148c6cbce1839bc01f51386f37bb4424dbab278c29" => :mavericks
  end

  depends_on :x11
  depends_on "pulseaudio"

  resource "rom" do
    url "http://fms.komkon.org/ColEm/ColEm37-Windows-bin.zip"
    sha256 "f4f8612f9cf695b20135ea445b086f1baadb40488033498fa9508f7918d70602"
  end

  def install
    chdir "ColEm/Unix" do
      inreplace "Makefile" do |s|
        pa = Formula["pulseaudio"]
        s.gsub! %r{(DEFINES\s*\+=\s*[-\/$()\w\t ]*)}, "\\1 -DPULSE_AUDIO"
        s.gsub! %r{(CFLAGS\s*\+=\s*[-\/$()\w\t ]*)}, "\\1 -I#{pa.include}\nLIBS += -L#{pa.lib} -lpulse-simple"
      end
      system "make"
      bin.install "colem"
    end
    resource("rom").stage { pkgshare.install "COLECO.ROM" }
  end

  def caveats; <<-EOS.undent
    No sound under OS X due to missing /dev/dsp.
    EOS
  end

  test do
    system "#{bin}/colem", "-help"
  end
end
