class Ski < Formula
  desc "Evade the deadly Yeti on your jet-powered skis"
  homepage "http://catb.org/~esr/ski/"
  url "http://www.catb.org/~esr/ski/ski-6.11.tar.gz"
  sha256 "8dd0335d093b3a0f4486abd269f2bde300d97d2972ef1467fd6dff5de9a31b26"

  bottle do
    cellar :any_skip_relocation
    sha256 "d6d39457830786bc0aa2bdd303804636cb675a707fa7f2a12b382882cf6cea91" => :sierra
    sha256 "fd3e643e162d93976d2b89cdfb40fe54bad73f6d02105e663c59e08d6623ab1d" => :el_capitan
    sha256 "fd3e643e162d93976d2b89cdfb40fe54bad73f6d02105e663c59e08d6623ab1d" => :yosemite
  end

  head do
    url "git://thyrsus.com/repositories/ski.git"
    depends_on "xmlto" => :build
  end

  # Reported upstream by email
  patch :DATA

  def install
    if build.head?
      ENV["XML_CATALOG_FILES"] = "#{etc}/xml/catalog"
      system "make"
    end
    bin.install "ski"
    man6.install "ski.6"
  end

  test do
    assert_match "Bye!", pipe_output("#{bin}/ski", "")
  end
end

__END__
--- ski-6.11/ski
+++ ski-6.11/ski
@@ -481,7 +481,7 @@
             colordict[ch] = curses.tparm(color, idx)
         else:
             colordict[ch] = ""
-    reset = curses.tigetstr("sgr0").decode("ascii") or ""
+    reset = (curses.tigetstr("sgr0") or "").decode("ascii")
     terrain_key = colorize(terrain_key)

     print("SKI!  Version %s.  Type ? for help." % version)
