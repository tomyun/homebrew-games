class Glulxe < Formula
  desc "Portable VM like the Z-machine"
  homepage "http://www.eblong.com/zarf/glulx/"
  url "http://eblong.com/zarf/glulx/glulxe-052.tar.gz"
  version "0.5.2"
  sha256 "2f056987b38cf5bab7c2990cd13e493628dd0774583fb26ff20c338be8343ca6"
  head "https://github.com/erkyrath/glulxe.git"

  option "with-glkterm", "Build with glkterm (without wide character support)"

  depends_on "cheapglk" => [:build, :optional]
  depends_on "glkterm" => [:build, :optional]
  depends_on "glktermw" => :build if build.without?("cheapglk") && build.without?("glkterm")

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

    inreplace "Makefile", "GLKINCLUDEDIR = ../cheapglk", "GLKINCLUDEDIR = #{glk.include}"
    inreplace "Makefile", "GLKLIBDIR = ../cheapglk", "GLKLIBDIR = #{glk.lib}"
    inreplace "Makefile", "Make.cheapglk", "Make.#{glk.name}"

    system "make"
    bin.install "glulxe"
  end

  test do
    if build.with? "cheapglk"
      assert shell_output("#{bin}/glulxe").start_with? "Welcome to the Cheap Glk Implementation"
    else
      assert pipe_output("#{bin}/glulxe -v").start_with? "GlkTerm, library version"
    end
  end
end
