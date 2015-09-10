class Qdae < Formula
  desc "Quick and Dirty Apricot Emulator"
  homepage "http://www.seasip.info/Unix/QDAE/"
  url "http://www.seasip.info/Unix/QDAE/qdae-0.0.10.tar.gz"
  sha256 "780752c37c9ec68dd0cd08bd6fe288a1028277e10f74ef405ca200770edb5227"

  depends_on "sdl"
  depends_on "libxml2"

  def install
    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    Data files are located in the following directory:
      #{share}/QDAE
    EOS
  end

  test do
    File.executable? "#{bin}/qdae"
  end
end
