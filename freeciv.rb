class Freeciv < Formula
  desc "A Free and Open Source empire-building strategy game"
  homepage "http://freeciv.wikia.com"
  url "https://downloads.sourceforge.net/project/freeciv/Freeciv%202.5/2.5.1/freeciv-2.5.1.tar.bz2"
  mirror "http://download.gna.org/freeciv/stable/freeciv-2.5.1.tar.bz2"
  sha256 "4e420a9ad91aa7966039ec3b63501725c8261a4ff734d56fe801414fae772696"

  bottle do
    sha256 "692109ea72bd34ceff8382dbe39c1e2017761308ed7b4edf5aa853995393042d" => :el_capitan
    sha256 "f9b09c2b87ab9417874fe6dff426f87630ba621f37aa11cc5753301fa5283514" => :yosemite
    sha256 "3887f6ed85f328247dac4cbdbd7d4a46b172e784567b17546537119d671171f6" => :mavericks
  end

  head do
    url "svn://svn.gna.org/svn/freeciv/trunk"
    depends_on "automake" => :build
    depends_on "autoconf" => :build
    depends_on "gettext" => :build
    depends_on "libtool" => :build
  end

  option "without-nls", "Disable NLS support"
  option "without-sdl", "Disable the SDL Freeciv client"

  depends_on "gettext" if build.with? "nls"
  depends_on "icu4c"
  depends_on "pkg-config" => :build
  depends_on "readline"

  depends_on "sdl" => :recommended
  if build.with? "sdl"
    depends_on "freetype"
    depends_on "sdl_image"
    depends_on "sdl_gfx"
    depends_on "sdl_mixer"
    depends_on "sdl_ttf"
  end

  depends_on "gtk+" => :recommended
  depends_on "gtk+3" => :optional
  if build.with?("gtk+") || build.with?("gtk+3")
    depends_on "atk"
    depends_on "glib"
    depends_on "pango"
  end
  depends_on "gdk-pixbuf" if build.with? "gtk+3"

  def install
    args = %W[
      --disable-debug
      --disable-dependency-tracking
      --disable-gtktest
      --prefix=#{prefix}
      --with-readline=#{Formula["readline"].opt_prefix}
    ]

    if build.without? "nls"
      args << "--disable-nls"
    else
      gettext = Formula["gettext"]
      args << "CFLAGS=-I#{gettext.include}"
      args << "LDFLAGS=-L#{gettext.lib}"
    end

    if build.head?
      inreplace "./autogen.sh", "libtoolize", "glibtoolize"
      system "./autogen.sh", *args
    else
      system "./configure", *args
    end

    system "make", "install"
  end

  test do
    system bin/"freeciv-manual"
    File.exist? testpath/"manual6.html"

    server = fork do
      system bin/"freeciv-server", "-l", testpath/"test.log"
    end
    sleep 5
    Process.kill("TERM", server)
    File.exist? testpath/"test.log"
  end
end
