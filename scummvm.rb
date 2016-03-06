class Scummvm < Formula
  desc "Graphic adventure game interpreter"
  homepage "http://scummvm.org/"
  url "http://www.scummvm.org/frs/scummvm/1.8.0/scummvm-1.8.0.tar.xz"
  sha256 "a85c23a2b1fcb7586a7527ecdbdf6c899a45ecbdcba28b9322057dc27914daa8"
  head "https://github.com/scummvm/scummvm.git"

  bottle do
    sha256 "20b37ba4b2833f9d1410229d70478878f685e4fac066edcde4596aa89cdce91d" => :yosemite
    sha256 "00b1d3d1f999a431d27b452c8d85763801b68845d25577288723b4e15f94a0de" => :mavericks
    sha256 "d7b6bf9e056151d493c0949e94adc662e572d4aaeb215bc2078b6e3a0e485b5c" => :mountain_lion
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
