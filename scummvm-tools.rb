class ScummvmTools < Formula
  desc "Collection of tools for ScummVM"
  homepage "http://www.scummvm.org/"
  url "http://www.scummvm.org/frs/scummvm-tools/1.9.0/scummvm-tools-1.9.0.tar.xz"
  sha256 "b7ab2e03c5a0efb71bb0c84434aa481331739b2b8759361d467e076b8410f938"
  head "https://github.com/scummvm/scummvm-tools.git"

  bottle do
    cellar :any
    sha256 "0bf37d9c5a58c3ba9c309224ade405a924f3bbbff1497f1ca027cc0647f5ef90" => :el_capitan
    sha256 "0d585039b34703ccb546e6a8fde2084f9445adc64543440e7532cf9d62db5f92" => :yosemite
    sha256 "02c01dfde3ed9275e15eeff783350a56f7798d6fedd3c4c4e5e89a0636fa7f94" => :mavericks
  end

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
