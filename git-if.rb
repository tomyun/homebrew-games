class GitIf < Formula
  desc "Glulx interpreter that is optimized for speed"
  homepage "http://ifarchive.org/indexes/if-archiveXprogrammingXglulxXinterpretersXgit.html"
  url "http://ifarchive.org/if-archive/programming/glulx/interpreters/git/git-134.zip"
  version "1.3.4"
  sha256 "3ef7bd4ffddfe617cf914ae2f46dc28a30b4c5989590f93c97c53b1eb71a36c2"
  head "https://github.com/DavidKinder/Git.git"

  bottle do
    cellar :any_skip_relocation
    rebuild 1
    sha256 "1c94d04b4e3817073679802e421d2671e187a92e00670db15734ba05ba986276" => :sierra
    sha256 "cc8ac3eb7effd10314d49eb715069d760a55492e0649bb70d49fe98b2b5498ce" => :el_capitan
    sha256 "4fb19d7927a61865453b9cb2dc38321d7d58859fefd3f99c6cb342a9752ffebb" => :yosemite
  end

  option "with-glkterm", "Build with glkterm (without wide character support)"

  depends_on "cheapglk" => [:build, :optional]
  depends_on "glkterm" => [:build, :optional]
  depends_on "glktermw" => :build if build.without?("cheapglk") && build.without?("glkterm")

  # Fixes an issue caused by the use of noreturn as a macro name
  patch do
    url "https://github.com/DavidKinder/Git/commit/36ac371e8fcbf118c12c3dca08a8dc60a5bac93a.patch"
    sha256 "a88ea0da5d323090156ba85441750221f4c790dc9d096002f241b1969f4b0226"
  end

  def install
    if build.with?("cheapglk") && build.with?("glkterm")
      odie "Options --with-cheapglk and --with-glkterm are mutually exclusive."
    end

    if build.with? "cheapglk"
      glk = Formula["cheapglk"]
    elsif build.with? "glkterm"
      glk = Formula["glkterm"]
    else
      glk = Formula["glktermw"]
    end

    inreplace "Makefile", "GLK = cheapglk", "GLK = #{glk.name}" if build.without? "cheapglk"
    inreplace "Makefile", "GLKINCLUDEDIR = ../$(GLK)", "GLKINCLUDEDIR = #{glk.include}"
    inreplace "Makefile", "GLKLIBDIR = ../$(GLK)", "GLKLIBDIR = #{glk.lib}"
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
