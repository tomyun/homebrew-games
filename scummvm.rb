class Scummvm < Formula
  desc "Graphic adventure game interpreter"
  homepage "https://www.scummvm.org/"
  url "https://www.scummvm.org/frs/scummvm/1.8.1/scummvm-1.8.1.tar.xz"
  sha256 "935f53d7e4c460fbc22c58fee5007d4858891e4961831f53f575a3594b7f612a"
  revision 1
  head "https://github.com/scummvm/scummvm.git"

  bottle do
    sha256 "dd3ddf5544b319a42a5b22d9cbf218718a2603621045bb2f89b08f4e6090c450" => :sierra
    sha256 "06a0f9f260808f18aa8bc640fb522d84ce1e6c919bb5f81d7a1ad1ce49f0a5ef" => :el_capitan
    sha256 "9715c2fccc82d5928ebd0c48d4248cdce160b14c0784cf9d6e95dc4f2c6a8f6e" => :yosemite
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
