class Angolmois < Formula
  desc "BM98-like rhythm game"
  homepage "http://mearie.org/projects/angolmois/"

  stable do
    url "https://github.com/lifthrasiir/angolmois/archive/angolmois-2.0-alpha2.tar.gz"
    version "2.0.0alpha2"
    sha256 "97ac3bff8a4800a539b1b823fd1638cedbb9910ebc0cc67196ec55d7720a7005"
    depends_on "sdl"
    depends_on "sdl_image"
    depends_on "sdl_mixer" => "with-smpeg"
    depends_on "smpeg"
  end

  head do
    url "https://github.com/lifthrasiir/angolmois.git"
    depends_on "sdl2"
    depends_on "sdl2_image"
    depends_on "sdl2_mixer" => "with-smpeg2"
    depends_on "smpeg2"
  end

  depends_on "pkg-config" => :build

  def install
    system "make"
    bin.install "angolmois"
  end

  test do
    assert_equal "#{version}", /Angolmois (\d+\.\d+(?:\.\d+)?) (\w+) (\d+)?/.match(shell_output "#{bin}/angolmois --version").to_a.drop(1).join
  end
end
