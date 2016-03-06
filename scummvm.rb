class Scummvm < Formula
  desc "Graphic adventure game interpreter"
  homepage "http://scummvm.org/"
  url "http://www.scummvm.org/frs/scummvm/1.8.0/scummvm-1.8.0.tar.xz"
  sha256 "a85c23a2b1fcb7586a7527ecdbdf6c899a45ecbdcba28b9322057dc27914daa8"
  head "https://github.com/scummvm/scummvm.git"

  bottle do
    sha256 "35bc5dffa36838b2983a850ebaae945c64949a60a5d83c294ccbd25f0fb2c436" => :el_capitan
    sha256 "c87a4805ea58be36b66a18f1403f15242cdfec186470645cfa64e5c3165cd62f" => :yosemite
    sha256 "d0b8e5667bb6b8aa878084c92065e275fce38a7acd501a065d6e90d1da5fd1ad" => :mavericks
  end

  option "with-all-engines", "Enable all engines (including broken or unsupported)"

  depends_on "sdl"
  depends_on "libvorbis" => :recommended
  depends_on "mad" => :recommended
  depends_on "flac" => :recommended
  depends_on "libmpeg2" => :optional
  depends_on "jpeg" => :recommended
  depends_on "libpng" => :recommended
  depends_on "theora" => :recommended
  depends_on "faad2" => :recommended
  depends_on "fluid-synth" => :recommended
  depends_on "freetype" => :recommended

  def install
    args = %W[
      --prefix=#{prefix}
      --enable-release
    ]
    args << "--enable-all-engines" if build.with? "all-engines"
    system "./configure", *args
    system "make"
    system "make", "install"
    (share+"pixmaps").rmtree
    (share+"icons").rmtree
  end

  test do
    system "#{bin}/scummvm", "-v"
  end
end
