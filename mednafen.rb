class Mednafen < Formula
  desc "Multi-system emulator"
  homepage "http://mednafen.fobby.net/"
  url "http://mednafen.fobby.net/releases/files/mednafen-0.9.38.6.tar.bz2"
  sha256 "9460da3c6cd8cb8a02293d51c958cbc6ab5555aa6d115b952d4db2e0f1067e47"

  bottle do
    sha1 "84e3203ab953fbed5a22499a2ad64aa6f17f4d80" => :yosemite
    sha1 "b251d8fb372df3d5665156a6bd49fd17a5eed618" => :mavericks
    sha1 "09ade315444535e750cb204d0280c9c7d833f12a" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "libsndfile"
  depends_on "gettext"

  needs :cxx11

  fails_with :clang do
    build 602
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
