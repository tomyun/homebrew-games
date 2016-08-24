class ScummvmTools < Formula
  desc "Collection of tools for ScummVM"
  homepage "http://www.scummvm.org/"
  url "http://www.scummvm.org/frs/scummvm-tools/1.8.0/scummvm-tools-1.8.0.tar.xz"
  sha256 "2c14050cee3fb8e178cb9ff16a4412ab584001757b4824c75b24240eb2d98bdd"
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
