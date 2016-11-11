class Xboard < Formula
  desc "Graphical user interface for chess"
  homepage "https://www.gnu.org/software/xboard/"
  url "https://ftpmirror.gnu.org/xboard/xboard-4.9.1.tar.gz"
  mirror "https://ftp.gnu.org/gnu/xboard/xboard-4.9.1.tar.gz"
  sha256 "2b2e53e8428ad9b6e8dc8a55b3a5183381911a4dae2c0072fa96296bbb1970d6"
  revision 1

  bottle do
    sha256 "07f61bc06c4beb4be13818b5fbde4b91b131610541f18afc7b5bff645f729bea" => :el_capitan
    sha256 "803662506f9c005806d866f0f68659d0ddce7a57bd0e5b87b4f10e0c17b74edd" => :yosemite
    sha256 "f35f2cd5fb44fd7190b98c0ef7650473f0c6480ba8b1f55458ca45fef9452ed5" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "fairymax" => :recommended
  depends_on "polyglot" => :recommended
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
