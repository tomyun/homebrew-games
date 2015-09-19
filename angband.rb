class Angband < Formula
  desc "Dungeon exploration game"
  homepage "http://rephial.org/"
  url "http://rephial.org/downloads/4.0/angband-4.0.2.tar.gz"
  sha256 "3be090111a597fd2f26860347db277347088677cc646bc3fdf560adf95fb7808"
  head "https://github.com/angband/angband.git"

  bottle do
    sha256 "bd67612ef2fe203c84f865b383b3df40601faf6144a02303c272dbad769a136b" => :el_capitan
    sha256 "963b83568c3577dedfed7e77d4ef5ebe7b609259831d92beeac9d6200af36146" => :yosemite
    sha256 "b09ef7697942b0ee214ad040c1a441aace8cdafaf0bae766e21d1bc68a226216" => :mavericks
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
