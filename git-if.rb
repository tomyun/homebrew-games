class GitIf < Formula
  desc "Glulx interpreter that is optimized for speed"
  homepage "http://ifarchive.org/indexes/if-archiveXprogrammingXglulxXinterpretersXgit.html"
  url "http://ifarchive.org/if-archive/programming/glulx/interpreters/git/git-134.zip"
  version "1.3.4"
  sha256 "3ef7bd4ffddfe617cf914ae2f46dc28a30b4c5989590f93c97c53b1eb71a36c2"
  head "https://github.com/DavidKinder/Git.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "4393b0734b1d8febce948dd2eb094cc7ab7b68b394ac294cac8dbdac61c26ff5" => :el_capitan
    sha256 "23c33be47e589e71960a4c42f61f08fc0f53f5a014c4a836b5c463b642b0f902" => :yosemite
    sha256 "abb4ac0944be059cd3ec66d22b16dffac742c9b88c72b1a438b6470c24122f4b" => :mavericks
  end

  option "with-cheapglk", "Build using cheapglk instead of glkterm"
  option "without-wide", "Disable glkterm wide character support"

  # http://www.eblong.com/zarf/glk/index.html
  resource "glkterm" do
    url "http://www.eblong.com/zarf/glk/glkterm-104.tar.gz"
    version "1.0.4"
    sha256 "473d6ef74defdacade2ef0c3f26644383e8f73b4f1b348e37a9bb669a94d927e"
  end

  resource "glktermw" do
    url "http://www.eblong.com/zarf/glk/glktermw-104.tar.gz"
    version "1.0.4"
    sha256 "5968630b45e2fd53de48424559e3579db0537c460f4dc2631f258e1c116eb4ea"
  end

  resource "cheapglk" do
    url "http://www.eblong.com/zarf/glk/cheapglk-104.tar.gz"
    version "1.0.4"
    sha256 "87f1c0a1f2df7b6dc9e34a48b026b0c7bc1752b9a320e5cda922df32ff40cb57"
  end

  # Fixes an issue caused by the use of noreturn as a macro name
  patch do
    url "https://github.com/DavidKinder/Git/commit/36ac371e8fcbf118c12c3dca08a8dc60a5bac93a.patch"
    sha256 "a88ea0da5d323090156ba85441750221f4c790dc9d096002f241b1969f4b0226"
  end

  def install
    glk_lib = libexec/"glk/lib"
    glk_include = libexec/"glk/include"
    glk = "glktermw"

    if build.with? "cheapglk"
      glk = "cheapglk"
      resource("cheapglk").stage do
        system "make"
        glk_lib.install "libcheapglk.a"
        glk_include.install "glk.h", "glkstart.h", "gi_blorb.h", "gi_dispa.h", "Make.cheapglk"
      end
    elsif build.without? "wide"
      glk = "glkterm"
      resource("glkterm").stage do
        system "make"
        glk_lib.install "libglkterm.a"
        glk_include.install "glk.h", "glkstart.h", "gi_blorb.h", "gi_dispa.h", "Make.glkterm"
      end
    else
      resource("glktermw").stage do
        inreplace "gtoption.h", "/* #define LOCAL_NCURSESW */", "#define LOCAL_NCURSESW"
        inreplace "Makefile", "-lncursesw", "-lncurses"
        system "make"
        glk_lib.install "libglktermw.a"
        glk_include.install "glk.h", "glkstart.h", "gi_blorb.h", "gi_dispa.h", "Make.glktermw"
      end
    end

    inreplace "Makefile", "#GLK = glkterm", "GLK = #{glk}"
    inreplace "Makefile", "GLKINCLUDEDIR = ../$(GLK)", "GLKINCLUDEDIR = #{glk_include}"
    inreplace "Makefile", "GLKLIBDIR = ../$(GLK)", "GLKLIBDIR = #{glk_lib}"
    inreplace "Makefile", /^OPTIONS = /, "OPTIONS = -DUSE_MMAP -DUSE_INLINE"

    system "make"
    bin.install "git" => "git-if"
  end

  test do
    if build.with? "cheapglk"
      assert shell_output("#{bin}/git-if").start_with? "usage: git gamefile.ulx"
    else
      assert pipe_output("#{bin}/git-if -v").start_with? "GlkTerm, library version"
    end
  end
end
