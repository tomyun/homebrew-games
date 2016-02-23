class Xoreos < Formula
  desc "Reimplementation of BioWare's Aurora engine"
  homepage "https://xoreos.org"
  url "https://github.com/xoreos/xoreos/releases/download/v0.0.4/xoreos-0.0.4.tar.gz"
  sha256 "71e075dca9ae7a4da4635627a050367d2b6401be13801815d36a0e511caa865e"
  head "https://github.com/xoreos/xoreos.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "libtool" => :build

  depends_on "boost"
  depends_on "faad2"
  depends_on "freetype"
  depends_on "glew"
  depends_on "sdl2"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "mad"
  depends_on "xvid"
  depends_on "xz"

  def install
    system "./autogen.sh"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /xoreos #{version}\+/, shell_output("#{bin}/xoreos --version")
  end
end
