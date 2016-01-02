class Qtads < Formula
  desc "TADS multimedia interpreter"
  homepage "http://qtads.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/qtads/qtads-2.x/2.1.6/qtads-2.1.6.tar.bz2"
  sha256 "33f29b4c1b225f1a1e7ad1405a1bb7eb8ec4b1d567eac48a120071f7793373c8"
  head "https://github.com/realnc/qtads.git"

  bottle do
    cellar :any
    sha256 "3247cdf051f31f837b86571cf0dc0818bc7a8399e00a81431c1e1da8bafe346c" => :el_capitan
    sha256 "200bb09ea75e8bfa4dd266544c266eddd7bcc1e03c3ac3be0f4a57aa09cb2330" => :yosemite
    sha256 "d320c148ada10a316b5aca7b659b8e0875d2ae50e862a66c80a2eb10a3f091f0" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "qt"
  depends_on "sdl"
  depends_on "sdl_mixer"
  depends_on "sdl_sound"

  def install
    system "qmake", "DEFINES+=NO_STATIC_TEXTCODEC_PLUGINS"
    system "make"
    prefix.install "QTads.app"
    bin.write_exec_script "#{prefix}/QTads.app/Contents/MacOS/QTads"
    man6.install "qtads.6"
  end
end
