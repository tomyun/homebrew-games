class MednafenServer < Formula
  desc "Netplay for mednafen emulator"
  homepage "http://mednafen.fobby.net/"
  url "http://mednafen.fobby.net/releases/files/mednafen-server-0.5.2.tar.gz"
  sha256 "4933e87e7072efa2ffa965dcc790080984523e83f49eeb49e20fadcca1a1ca19"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
    pkgshare.install "standard.conf"
  end

  def caveats; <<-EOS.undent
    A sample configuration file is located at:
      #{pkgshare}/standard.conf
    EOS
  end

  test do
    File.executable? "#{bin}/mednafen-server"
  end
end
