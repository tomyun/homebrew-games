class Scummvm < Formula
  desc "Graphic adventure game interpreter"
  homepage "https://www.scummvm.org/"
  url "https://www.scummvm.org/frs/scummvm/1.8.1/scummvm-1.8.1.tar.xz"
  sha256 "935f53d7e4c460fbc22c58fee5007d4858891e4961831f53f575a3594b7f612a"
  revision 1
  head "https://github.com/scummvm/scummvm.git"

  bottle do
    sha256 "56a10ca1764996ed9e4acd02673a865de0e5fa0a0ba15c6b238844c14f57a012" => :el_capitan
    sha256 "db353c793eb689d1f811f23b3aa4c9880970a19c71ff210b731a59935d3bfa73" => :yosemite
    sha256 "615bd0d68ae8765e3523055a43f520bef2b963c50bc3dde4a9539bb500b0e311" => :mavericks
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
