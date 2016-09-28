class Sdlpop < Formula
  desc "Open-source port of Prince of Persia"
  homepage "https://github.com/NagyD/SDLPoP"
  url "https://github.com/NagyD/SDLPoP/archive/v1.16.tar.gz"
  sha256 "4198eecdb2c4fed8f609af810962c943572df83da99c571146cee1596e7ee55b"

  depends_on "pkg-config" => :build
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"

  def install
    system "make"
    doc.install Dir["doc/*"]

    # Use var directory to keep save and replay files
    pkgshare.install Dir["*.DAT"]
    pkgshare.install "data"
    pkgvar = var/"sdlpop"
    pkgvar.install_symlink Dir["#{pkgshare}/*.DAT"]
    pkgvar.install_symlink pkgshare/"data"
    pkgvar.install "SDLPoP.ini" unless (pkgvar/"SDLPoP.ini").exist?

    # Data files should be in the working directory
    libexec.install "prince"
    (bin/"prince").write <<-EOS.undent
      #!/bin/bash
      cd "#{pkgvar}" && exec "#{libexec}/prince" $@
      EOS
  end

  def caveats; <<-EOS.undent
    Data including save and replay files are stored in the following directory:
      #{var}/sdlpop
    EOS
  end
end
