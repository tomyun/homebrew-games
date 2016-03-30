class Libggz < Formula
  desc "The libggz library wraps many common low-level functions."
  homepage "http://dev.ggzgamingzone.org/libraries/libggz/"
  url "http://mirrors.ibiblio.org/ggzgamingzone/ggz/0.0.14.1/libggz-0.0.14.1.tar.gz"
  sha256 "54301052a327f2ff3f2d684c5b1d7920e8601e13f4f8d5f1d170e5a7c9585e85"

  # Libggz of this version is unable to build with gnutls-30 and later.
  depends_on "libgcrypt"
  depends_on "gettext"

  def install
    ENV.append "CPPFLAS", "-I#{Formula["gettext"].opt_prefix}/include"
    ENV.append "LDFLAGS", "-L#{Formula["gettext"].opt_prefix}/lib"

    system "./configure", "--disable-debug",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-gcrypt"
    system "make", "check"
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
     #include <string.h>

     #include <ggz.h>

     int main(void)
     {
       int errs = 0;
       char *teststr, *instr, *outstr;

       teststr = "&quot; >< &&amp";
       instr = teststr;
       outstr = ggz_xml_escape(instr);
       instr = ggz_xml_unescape(outstr);
       if(strcmp(instr, teststr)) {
         errs++;
       }
       ggz_free(instr);
       ggz_free(outstr);
       ggz_memory_check();

       return errs;
     }
    EOS
    system ENV.cc, "test.c", ENV.cppflags, "-L/usr/lib", "-L#{lib}", "-lggz", "-o", "test"
    system "./test"
  end
end
