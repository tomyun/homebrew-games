class Glulxe < Formula
  desc "Portable VM like the Z-machine"
  homepage "http://www.eblong.com/zarf/glulx/"
  url "http://eblong.com/zarf/glulx/glulxe-053.tar.gz"
  version "0.5.3"
  sha256 "dbbb99a47ca176bee2b369eb40a6bf06994f2c10cf121b63a7860f61d69778fd"
  head "https://github.com/erkyrath/glulxe.git"

  bottle do
    cellar :any_skip_relocation
    sha256 "3f1e25df9b3ad7c16a4aed52029f3db0d7787db3f845c4e53ebdc1d39d2df52c" => :sierra
    sha256 "3ed4fe1d839e9e1cc878a2d1085045db77be40be647abe527badbead1d7cbf05" => :el_capitan
    sha256 "b6a652f183e84c3057e3b13463d82a17c3f679b0e769ae3a637f434327021881" => :yosemite
  end

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
