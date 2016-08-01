class Xboard < Formula
  desc "Graphical user interface for chess"
  homepage "https://www.gnu.org/software/xboard/"
  url "https://ftpmirror.gnu.org/xboard/xboard-4.9.1.tar.gz"
  mirror "https://ftp.gnu.org/gnu/xboard/xboard-4.9.1.tar.gz"
  sha256 "2b2e53e8428ad9b6e8dc8a55b3a5183381911a4dae2c0072fa96296bbb1970d6"

  bottle do
    sha256 "962538e8ccc89f02b43c29747864591b0bf2a97087addb5ee9695acf262bba6b" => :yosemite
    sha256 "ddfcc515d630a777c1512df1f29189eb9e0c7f47246d42b1f5ba8b8614fbe81b" => :mavericks
    sha256 "67f9d1b523f0d387f91e92ee9874ff14e5cf7cb3e8e5473bac7353567e471cde" => :mountain_lion
  end

  depends_on "pkg-config" => :build
  depends_on "fairymax" => :recommended
  depends_on "gettext"
  depends_on "cairo"
  depends_on "librsvg"
  depends_on "gtk+"

  def install
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
