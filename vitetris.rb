class Vitetris < Formula
  desc "Terminal-based Tetris clone"
  homepage "http://www.victornils.net/tetris/"
  url "http://www.victornils.net/tetris/vitetris-0.57.tar.gz"
  sha256 "0c9fa6c8b16e2f8968f65e16a87f1bcd39b827d510c6efb0771f0400ab91cdc2"

  # remove a 'strip' option not supported on OS X and root options for
  # 'install'
  patch :DATA

  def install
    system "./configure", "--prefix=#{prefix}", "--without-xlib"
    system "make", "install"
  end

  test do
    system "#{bin}/tetris", "-hiscore"
  end
end
__END__
--- a/Makefile  2013-10-07 11:57:18.000000000 +0200
+++ b/Makefile  2013-10-07 11:57:29.000000000 +0200
@@ -5,7 +5,7 @@
 # Uncomment to change the default.  (Only used in Unix-like systems.)
 #HISCORE_FILENAME = /var/games/vitetris-hiscores

-INSTALL = install -oroot -groot
+INSTALL = install

 default: build
	@echo Done.
@@ -18,7 +18,7 @@
  cd src; $(MAKE) tetris
	mv -f src/tetris$(EXE) $(PROGNAME)
	@echo stripping symbols to reduce program size:
-	-strip --strip-all $(PROGNAME)
+	-strip $(PROGNAME)

 gameserver: src/netw/gameserver.c
	cd src/netw; $(MAKE) gameserver
