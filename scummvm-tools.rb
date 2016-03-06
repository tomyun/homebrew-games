class ScummvmTools < Formula
  desc "Collection of tools for ScummVM"
  homepage "http://www.scummvm.org/"
  url "http://www.scummvm.org/frs/scummvm-tools/1.8.0/scummvm-tools-1.8.0.tar.xz"
  sha256 "2c14050cee3fb8e178cb9ff16a4412ab584001757b4824c75b24240eb2d98bdd"
  head "https://github.com/scummvm/scummvm-tools.git"

  depends_on "boost"
  depends_on "flac"
  depends_on "freetype"
  depends_on "libpng"
  depends_on "libvorbis"
  depends_on "mad"
  depends_on "wxmac" => :recommended

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/scummvm-tools-cli", "--list"
  end
end
