class CdogsSdl < Formula
  desc "Classic overhead run-and-gun game"
  homepage "https://cxong.github.io/cdogs-sdl/"
  url "https://github.com/cxong/cdogs-sdl/archive/0.6.1.tar.gz"
  sha256 "36035451286e3dd8af036ebfd84eb8ae4b9fa84bfc07a0bf2600cf7a78cbc167"
  head "https://github.com/cxong/cdogs-sdl.git"

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
