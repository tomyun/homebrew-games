class Glulxe < Formula
  desc "Portable VM like the Z-machine"
  homepage "http://www.eblong.com/zarf/glulx/"
  url "http://eblong.com/zarf/glulx/glulxe-052.tar.gz"
  version "0.5.2"
  sha256 "2f056987b38cf5bab7c2990cd13e493628dd0774583fb26ff20c338be8343ca6"
  head "https://github.com/erkyrath/glulxe.git"

  # http://www.eblong.com/zarf/glk/index.html
  resource "glkterm" do
    url "http://www.eblong.com/zarf/glk/glkterm-104.tar.gz"
    version "1.0.4"
    sha256 "473d6ef74defdacade2ef0c3f26644383e8f73b4f1b348e37a9bb669a94d927e"
  end

  def install
    glkterm_lib = libexec/"glkterm/lib"
    glkterm_include = libexec/"glkterm/include"

    resource("glkterm").stage do
      system "make"
      glkterm_lib.install "libglkterm.a"
      glkterm_include.install "glk.h", "glkstart.h", "gi_blorb.h", "gi_dispa.h", "Make.glkterm"
    end

    inreplace "Makefile", "GLKINCLUDEDIR = ../cheapglk", "GLKINCLUDEDIR = #{glkterm_include}"
    inreplace "Makefile", "GLKLIBDIR = ../cheapglk", "GLKLIBDIR = #{glkterm_lib}"
    inreplace "Makefile", "Make.cheapglk", "Make.glkterm"

    system "make"
    bin.install "glulxe"
  end
end
