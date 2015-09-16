class NestopiaUe < Formula
  desc "Nestopia UE (Undead Edition): NES emulator"
  homepage "http://0ldsk00l.ca/nestopia/"
  url "https://downloads.sourceforge.net/project/nestopiaue/1.46/nestopia-1.46.2.tgz"
  sha256 "4a5065726ad9e7a120a2c6aa39b9c0904090119998a4d690d4deb5e374118fc0"
  head "https://github.com/rdanbrook/nestopia.git"

  depends_on "sdl2"
  depends_on "libao"
  depends_on "libarchive"

  def install
    inreplace "Makefile" do |s|
      # Use Apple OpenGL.framework
      s.gsub! /-lGL -lGLU/, "-framework OpenGL"
      # Prevent linker error with clang
      s.gsub! "--as-needed", ""
      # Disable GTK+ UI
      s.gsub! /.*(gtk|GTK).*/, ""
    end
    # Adjust OpenGL header for OS X, already patched upstream
    # https://github.com/rdanbrook/nestopia/commit/acfec3370b8bf44f5703915c36a36a7c70fc8c65
    inreplace "source/unix/video.h", "GL/", "OpenGL/" if build.stable?
    # Mac has no Right Ctrl key for 1P Start, so let's map Return by default, reported upstream
    # https://github.com/rdanbrook/nestopia/pull/152
    inreplace "source/unix/input.cpp", "Right Ctrl", "Return"
    system "make", "PREFIX=#{prefix}", "DATADIR=#{pkgshare}"
    bin.install "nestopia"
    pkgshare.install "NstDatabase.xml"
  end

  test do
    assert_match /Nestopia UE #{version}$/, shell_output("#{bin}/nestopia --version")
  end
end
