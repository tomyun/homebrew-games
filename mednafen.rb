class Mednafen < Formula
  desc "Multi-system emulator"
  homepage "http://mednafen.fobby.net/"
  url "http://mednafen.fobby.net/releases/files/mednafen-0.9.39.1.tar.bz2"
  sha256 "3d97bf160fc9679b1a1c8082305d0d3906d867a6ba2be93232aa9d3024ba84a5"

  bottle do
    sha256 "5e6ee2d9fec7648dc3d16ca31cb802c56d85b7a0d25a6b498b3e5273ca2a01b4" => :el_capitan
    sha256 "eed2cc3a3c3c53f763b4bdd7adf9f318a1e114facc2ecb7e7d6fd996fdbba80b" => :yosemite
    sha256 "e4d5032b153f690acff4f7ee167fcf05f92ba70acf8e4b2cb7eca264632843c4" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "sdl"
  depends_on "libsndfile"
  depends_on "gettext"

  # Fix libco compilation issue on OS X
  # http://forum.fobby.net/index.php?t=msg&goto=4469
  patch :DATA

  needs :cxx11

  fails_with :clang do
    build 703
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

__END__
diff --git a/src/snes/src/lib/libco/libco.h b/src/snes/src/lib/libco/libco.h
index 5b10b2a..95147a6 100644
--- a/src/snes/src/lib/libco/libco.h
+++ b/src/snes/src/lib/libco/libco.h
@@ -18,6 +18,8 @@
   #if defined(_MSC_VER)
    /* Untested */
    #define force_text_section __declspec(allocate(".text"))
+  #elif defined(__APPLE__) && defined(__MACH__)
+   #define force_text_section __attribute__((section("__TEXT,__text")))
   #else
    #define force_text_section __attribute__((section(".text")))
   #endif
