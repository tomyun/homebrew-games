class Fmsx < Formula
  desc "MSX emulator"
  homepage "http://fms.komkon.org/fMSX/"
  url "http://fms.komkon.org/fMSX/fMSX43.zip"
  version "4.3"
  sha256 "b8feba2b052a0426a418c3051c24ae64376eae95c7c5363021484d23df7e30af"

  bottle do
    cellar :any
    sha256 "c1da46185a0ee2160a2d53ccf19606b26e33e816d5e207e3a2883876c2c4dda6" => :el_capitan
    sha256 "e911bfd042c45372b8a1dd534bcdd3c80fc50bd050fc675a055588603f6636a4" => :yosemite
    sha256 "cb008ad2626e42d08c4128148c6cbce1839bc01f51386f37bb4424dbab278c29" => :mavericks
  end

  depends_on :x11
  depends_on "pulseaudio"

  def install
    chdir "fMSX/Unix" do
      inreplace "Makefile" do |s|
        pa = Formula["pulseaudio"]
        s.gsub! /(DEFINES\s*\+=\s*[-\/$()\w\t ]*)/, "\\1 -DPULSE_AUDIO"
        s.gsub! /(CFLAGS\s*\+=\s*[-\/$()\w\t ]*)/, "\\1 -I#{pa.include}\nLIBS += -L#{pa.lib} -lpulse-simple"
      end
      system "make"
      bin.install "fmsx"
    end
    pkgshare.install "fMSX/ROMs"
  end

  def caveats; <<-EOS.undent
    No sound under OS X due to missing /dev/dsp.
    Bundled ROM files are located the following directory:
      #{pkgshare}/ROMs
    EOS
  end

  test do
    system "#{bin}/fmsx", "-help"
  end
end
