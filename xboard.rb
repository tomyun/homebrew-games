class Xboard < Formula
  desc "Graphical user interface for chess"
  homepage "https://www.gnu.org/software/xboard/"
  url "https://ftpmirror.gnu.org/xboard/xboard-4.9.1.tar.gz"
  mirror "https://ftp.gnu.org/gnu/xboard/xboard-4.9.1.tar.gz"
  sha256 "2b2e53e8428ad9b6e8dc8a55b3a5183381911a4dae2c0072fa96296bbb1970d6"
  revision 1

  bottle do
    sha256 "95495210b949f1acb8f90d7171e8f60681cd9c556722141fef3869167a3f3fd8" => :sierra
    sha256 "69d6e3d9a107028bc38f47fde16ccebe03236032fedee29388363c1ff3e0227f" => :el_capitan
    sha256 "a715d902478cdf0d4d2e2e205d5119159c670f8ab7f2bd90c28afda4d33d7023" => :yosemite
  end

  head do
    url "git://git.sv.gnu.org/xboard.git"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  depends_on "pkg-config" => :build
  depends_on "fairymax" => :recommended
  depends_on "polyglot" => :recommended
  depends_on "gettext"
  depends_on "cairo"
  depends_on "librsvg"
  depends_on "gtk+"

  def install
    system "./autogen.sh" if build.head?
    args = ["--prefix=#{prefix}",
            "--with-gtk",
            "--without-Xaw",
            "--disable-zippy"]

    system "./configure", *args
    system "make"
    system "make", "install"
  end

  test do
    system bin/"xboard", "--help"
  end
end
