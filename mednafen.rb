class Mednafen < Formula
  desc "Multi-system emulator"
  homepage "http://mednafen.fobby.net/"
  url "http://mednafen.fobby.net/releases/files/mednafen-0.9.39.2.tar.bz2"
  sha256 "b42470b2ddf68ce0747f5b8ba4e1d1c3047fa8c45b8e168da43f3e2461ec34cc"

  bottle do
    sha256 "5e6ee2d9fec7648dc3d16ca31cb802c56d85b7a0d25a6b498b3e5273ca2a01b4" => :el_capitan
    sha256 "eed2cc3a3c3c53f763b4bdd7adf9f318a1e114facc2ecb7e7d6fd996fdbba80b" => :yosemite
    sha256 "e4d5032b153f690acff4f7ee167fcf05f92ba70acf8e4b2cb7eca264632843c4" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "libsndfile"
  depends_on "gettext"

  needs :cxx11

  fails_with :clang do
    build 800
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
    assert_equal version.to_s, shell_output("#{bin}/mednafen -dump_modules_def M >/dev/null || head -n 1 M").chomp
  end
end
