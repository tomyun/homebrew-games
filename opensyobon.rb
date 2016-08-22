class Opensyobon < Formula
  desc "Parody of Super Mario Bros"
  homepage "http://opensyobon.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/opensyobon/src/SyobonAction_rc2_src.tar.gz"
  version "1.0rc2"
  sha256 "a61a621de7e4603be047e8666c0376892200f2876c244fb2adc9e4afebc79728"
  revision 1

  bottle do
    cellar :any
    sha256 "3094504f02679e5fa7d7952fc46ebfcd2ff21b6b83dde646935ac4c646f78ea8" => :el_capitan
    sha256 "0d3052c23939438753138ff636d37631b6335073d9bbd34ab3002cdaa27c57c4" => :yosemite
    sha256 "9783443a25ad14d304f30c94047e43af514d51707da105b8b204e7ef69fb402e" => :mavericks
  end

  depends_on "sdl"
  depends_on "sdl_gfx"
  depends_on "sdl_image"
  depends_on "sdl_mixer"
  depends_on "sdl_ttf"

  resource "data" do
    url "https://downloads.sourceforge.net/project/opensyobon/src/SyobonAction_rc2_data.tar.gz"
    sha256 "073be7634600df28909701fa132c8e474de1ff9647bf05816f80416be3bcaa9f"
  end

  def install
    inreplace "Makefile", "gcc", ENV.cxx
    inreplace "DxLib.cpp", /(setlocale)/, '//\1'
    system "make"
    pkgshare.install "SyobonAction"
    pkgshare.install resource("data")
    (bin/"SyobonAction").write <<-EOS.undent
      #!/bin/sh
      cd "#{pkgshare}" && exec ./SyobonAction "$@"
      EOS
  end

  test do
    File.executable? "#{pkgshare}/SyobonAction"
  end
end
