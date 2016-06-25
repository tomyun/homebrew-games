class Mednafen < Formula
  desc "Multi-system emulator"
  homepage "http://mednafen.fobby.net/"
  url "http://mednafen.fobby.net/releases/files/mednafen-0.9.38.7.tar.bz2"
  sha256 "1bb3beef883a325c35d1a1ce14959c307a4c321f2ea29d4ddb216c6dd03aded8"
  revision 1

  bottle do
    sha256 "84b30d74f50be443498a69013020f513f928216354770d8908140ddb72a05a5e" => :el_capitan
    sha256 "b89f7ead0584a47fb8a1812c7223952ab8f2f744cd2a3af1d0b3f8399b8a74fb" => :yosemite
    sha256 "6cbc38be18304a05ef463ebb9b848dc81fd713b0af45c896ec1bb7b0c4082531" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "libsndfile"
  depends_on "gettext"

  needs :cxx11

  fails_with :clang do
    build 703
    cause <<-EOS.undent
      LLVM miscompiles some loop code with optimization
      https://llvm.org/bugs/show_bug.cgi?id=15470
      EOS
  end

  def install
    # Fix ambiguous call of abs() with gcc-6
    # http://forum.fobby.net/index.php?t=msg&th=1318
    inreplace "src/cdrom/CDAccess_CCD.cpp", "abs(lba - s)", "abs((int)(lba - s))"

    ENV.cxx11
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/mednafen -dump_modules_def M >/dev/null || head -n 1 M").chomp
  end
end
