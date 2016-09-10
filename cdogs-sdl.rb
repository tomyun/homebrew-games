class CdogsSdl < Formula
  desc "Classic overhead run-and-gun game"
  homepage "https://cxong.github.io/cdogs-sdl/"
  url "https://github.com/cxong/cdogs-sdl/archive/0.6.2.tar.gz"
  sha256 "d6f421c760b15b706bdfc79ed8d18802dc2e8efeefabb69a31679c9b51f328ab"
  head "https://github.com/cxong/cdogs-sdl.git"

  bottle do
    sha256 "a8ccf539f205813574832b014217d57134dd1e586c48f39002396c5fc0bce3e8" => :el_capitan
    sha256 "42e4bb1a2ac861e97e5618cd5b3dec0d5863eef7a8dad695429210211b67d029" => :yosemite
    sha256 "8ec7c95c87f7776e9c563a770739000395cfc65bc7471ad07590dca9b105329b" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"

  def install
    args = std_cmake_args
    args << "-DCDOGS_DATA_DIR=#{pkgshare}/"
    system "cmake", ".", *args
    system "make"
    prefix.install "src/cdogs-sdl.app"
    bin.write_exec_script "#{prefix}/cdogs-sdl.app/Contents/MacOS/cdogs-sdl"
    pkgshare.install ["data", "dogfights", "graphics", "missions", "music", "sounds"]
    doc.install Dir["doc/*"]
  end

  test do
    server = fork do
      system "#{bin}/cdogs-sdl"
    end
    sleep 5
    Process.kill("TERM", server)
  end
end
