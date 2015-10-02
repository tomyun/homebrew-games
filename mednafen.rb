class Mednafen < Formula
  desc "Multi-system emulator"
  homepage "http://mednafen.fobby.net/"
  url "http://mednafen.fobby.net/releases/files/mednafen-0.9.38.7.tar.bz2"
  sha256 "1bb3beef883a325c35d1a1ce14959c307a4c321f2ea29d4ddb216c6dd03aded8"

  bottle do
    sha256 "b6a19caa842e3e136ee90bc3f817a92212a0bcb26b6c41fa58e0ad3b2f053be9" => :yosemite
    sha256 "d58c5ea9c861c2b5bf7bd0f1cade621911748717dbcb66507f93b675dcd213fa" => :mavericks
    sha256 "c05c05f4479c5d148469064dd13c1e67ebb8a0675fa53a9d9158ed274551a368" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "libsndfile"
  depends_on "gettext"

  needs :cxx11

  fails_with :clang do
    build 700
    cause <<-EOS.undent
      LLVM miscompiles some loop code with optimization
      https://llvm.org/bugs/show_bug.cgi?id=15470
      EOS
  end

  def install
    ENV.cxx11
    system "./configure", "--prefix=#{prefix}", "--disable-dependency-tracking"
    system "make", "install"
  end

  test do
    assert_equal "#{version}", shell_output("#{bin}/mednafen -dump_modules_def M >/dev/null || head -n 1 M").chomp
  end
end
