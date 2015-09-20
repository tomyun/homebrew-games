class Curseofwar < Formula
  desc "Fast-paced action strategy game"
  homepage "https://a-nikolaev.github.io/curseofwar/"
  url "https://github.com/a-nikolaev/curseofwar/archive/v1.2.0.tar.gz"
  sha256 "91b7781e26341faa6b6999b6baf6e74ef532fa94303ab6a2bf9ff6d614a3f670"
  head "https://github.com/a-nikolaev/curseofwar.git"

  depends_on "sdl" => :optional

  def install
    system "make"
    bin.install "curseofwar"
    man6.install "curseofwar.6"

    if build.with? "sdl"
      system "make", "SDL=yes"
      bin.install "curseofwar-sdl"
      man6.install "curseofwar-sdl.6"
      pkgshare.install "images"
    end
  end

  test do
    assert_equal "#{version}", shell_output("#{bin}/curseofwar -v", 1).chomp
    assert_equal "#{version}", shell_output("#{bin}/curseofwar-sdl -v", 1).chomp if build.with? "sdl"
  end
end
