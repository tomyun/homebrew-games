class Mednafen < Formula
  desc "Multi-system emulator"
  homepage "http://mednafen.fobby.net/"
  url "http://mednafen.fobby.net/releases/files/mednafen-0.9.38.7.tar.bz2"
  sha256 "1bb3beef883a325c35d1a1ce14959c307a4c321f2ea29d4ddb216c6dd03aded8"

  bottle do
    sha256 "31809d08bae8a6a6b132a10b5bdbbc01910306e62b137dfcd71f53709814fee9" => :el_capitan
    sha256 "ef9ac996f93e94b84286723d3f29a55cb4e73bab60a1a97ea990d50c95ed202f" => :yosemite
    sha256 "6c2c21dd225e9e3c431640cf90706ff1318b4de4f2595dc5aef15af71ca04dfa" => :mavericks
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
