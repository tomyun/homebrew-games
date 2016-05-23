class Hatari < Formula
  desc "Atari ST/STE/TT/Falcon emulator"
  homepage "http://hatari.tuxfamily.org"
  url "http://download.tuxfamily.org/hatari/1.9.0/hatari-1.9.0.tar.bz2"
  sha256 "b2b56e6cbe7f8769a5e8b1d96599f392d9351b44cacf959da6905da06d30e992"
  revision 1
  head "http://hg.tuxfamily.org/mercurialroot/hatari/hatari", :using => :hg, :branch => "default"

  bottle do
    cellar :any
    sha256 "e0011e9e4f0c70954d10082c0665e46b49fd98dd41e61928247f710c9f5d9129" => :el_capitan
    sha256 "0353909d1e922d9b0ae77b4b89b99297769544d0565cfd40f2b01a3065bcf9a6" => :yosemite
    sha256 "a652a30950ea90b36d8c550b54a30413fafc6918a8385bddaecb5d1de3ceada4" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "libpng"
  depends_on "sdl"
  depends_on "portaudio"

  # Download EmuTOS ROM image
  resource "emutos" do
    url "https://downloads.sourceforge.net/project/emutos/emutos/0.9.6/emutos-512k-0.9.6.zip"
    sha256 "2c7d57cac6792d0c7e921f9655f224b039402283dd24c894b085c7b6e9a053a6"
  end

  def install
    # Set .app bundle destination
    inreplace "src/CMakeLists.txt", "/Applications", prefix
    system "cmake", *std_cmake_args
    system "make"
    prefix.install "src/Hatari.app"
    bin.write_exec_script "#{prefix}/Hatari.app/Contents/MacOS/hatari"
    resource("emutos").stage do
      (prefix/"Hatari.app/Contents/Resources").install "etos512k.img" => "tos.img"
    end
  end

  test do
    assert_match /Hatari v#{version} -/, shell_output("#{bin}/hatari -v", 1)
  end
end
