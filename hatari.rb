class Hatari < Formula
  desc "Atari ST/STE/TT/Falcon emulator"
  homepage "http://hatari.tuxfamily.org"
  url "http://download.tuxfamily.org/hatari/1.9.0/hatari-1.9.0.tar.bz2"
  sha256 "b2b56e6cbe7f8769a5e8b1d96599f392d9351b44cacf959da6905da06d30e992"
  head "http://hg.tuxfamily.org/mercurialroot/hatari/hatari", :using => :hg, :branch => "default"

  depends_on "cmake" => :build
  depends_on "libpng"
  depends_on "sdl"
  depends_on "portaudio"

  # Download EmuTOS ROM image
  resource "emutos" do
    url "https://downloads.sourceforge.net/project/emutos/emutos/0.9.4/emutos-512k-0.9.4.zip"
    sha256 "a8445ce74bf642fecf237953a20641a2e97b74feaadc7fb7149e8221634f4218"
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
