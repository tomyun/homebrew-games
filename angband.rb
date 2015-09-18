class Angband < Formula
  desc "Dungeon exploration game"
  homepage "http://rephial.org/"
  url "http://rephial.org/downloads/4.0/angband-4.0.2.tar.gz"
  sha256 "3be090111a597fd2f26860347db277347088677cc646bc3fdf560adf95fb7808"
  head "https://github.com/angband/angband.git"

  bottle do
    sha256 "ece28191291c732d1a9c77f52154d0a7a1ac9b6a64cacafd56ed226e8411178a" => :yosemite
    sha256 "4dfdf04dcdad019c47c12239a60e3d75ef72968c37dd8de5ccd8f4d59d0f26db" => :mavericks
    sha256 "4169c9197bc346c86e170406afb893ebf1efbed914152edb0890bfbd108ddb84" => :mountain_lion
  end

  option "with-cocoa", "Install Cocoa app"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on :x11 => :optional
  depends_on "homebrew/dupes/tcl-tk" => "with-x11" if build.with? :x11
  depends_on "sdl" => :optional
  if build.with? "sdl"
    depends_on "sdl_image"
    depends_on "sdl_ttf"
    depends_on "sdl_mixer" => "with-smpeg"
  end

  def install
    ENV["NCURSES_CONFIG"] = "#{MacOS.sdk_path}/usr/bin/ncurses5.4-config"
    system "./autogen.sh"
    args = %W[
      --prefix=#{prefix}
      --bindir=#{bin}
      --libdir=#{libexec}
      --enable-curses
      --disable-ncursestest
      --disable-sdltest
      --with-ncurses-prefix=#{MacOS.sdk_path}/usr
    ]
    args << "--disable-x11" if build.without? :x11
    args << "--enable-sdl" if build.with? "sdl"

    system "./configure", *args
    system "make"
    system "make", "install"

    if build.with? "cocoa"
      cd "src" do
        system "make", "-f", "Makefile.osx"
      end
      prefix.install "Angband.app"
    end
  end

  test do
    system bin/"angband", "--help"
  end
end
