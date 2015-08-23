class Fmsx < Formula
  desc "MSX emulator"
  homepage "http://fms.komkon.org/fMSX/"
  url "http://fms.komkon.org/fMSX/fMSX42.zip"
  version "4.2"
  sha256 "7040bd61b309d4b514c20c7413d48f9b816e2f91e8bf7bb268d6143cbaa75e00"

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
    pkgshare.install "ROMs"
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
