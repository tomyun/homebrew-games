class Cheapglk < Formula
  desc "Extremely minimal Glk library"
  homepage "http://www.eblong.com/zarf/glk/index.html"
  url "http://www.eblong.com/zarf/glk/cheapglk-104.tar.gz"
  version "1.0.4"
  sha256 "87f1c0a1f2df7b6dc9e34a48b026b0c7bc1752b9a320e5cda922df32ff40cb57"

  keg_only "Conflicts with other Glk libraries"

  def install
    system "make"

    lib.install "libcheapglk.a"
    include.install "glk.h", "glkstart.h", "gi_blorb.h", "gi_dispa.h", "Make.cheapglk"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include "glk.h"
      #include "glkstart.h"

      glkunix_argumentlist_t glkunix_arguments[] = {
          { NULL, glkunix_arg_End, NULL }
      };

      int glkunix_startup_code(glkunix_startup_t *data)
      {
          return TRUE;
      }

      void glk_main()
      {
          glk_exit();
      }
    EOS
    system ENV.cc, "test.c", "-I#{include}", "-L#{lib}", "-lcheapglk", "-o", "test"
    system "echo test | ./test"
  end
end
