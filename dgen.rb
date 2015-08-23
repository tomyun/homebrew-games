class Dgen < Formula
  desc "Sega Genesis / Mega Drive emulator"
  homepage "http://dgen.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/dgen/dgen/1.33/dgen-sdl-1.33.tar.gz"
  sha256 "99e2c06017c22873c77f88186ebcc09867244eb6e042c763bb094b02b8def61e"
  head do
    url "git://git.code.sf.net/p/dgen/dgen"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
  end

  option "with-docs", "Build documentation"
  option "with-debugger", "Enable debugger"

  depends_on "sdl"
  depends_on "libarchive"
  depends_on "doxygen" if build.with? "docs"

  def install
    args = %W[
      --disable-silent-rules
      --disable-dependency-tracking
      --disable-sdltest
      --prefix=#{prefix}
    ]
    if build.with? "debugger"
      args << "--enable-debugger"
    end
    system "./autogen.sh" if build.head?
    system "./configure", *args
    system "make", "install"
  end

  def caveats; <<-EOS.undent
    If some keyboard inputs do not work, try modifying configuration:
      ~/.dgen/dgenrc
    EOS
  end

  test do
    assert_equal "DGen/SDL version #{version}", shell_output("#{bin}/dgen -v").chomp
  end
end
