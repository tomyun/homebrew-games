class Frobtads < Formula
  desc "TADS interpreter and compilers"
  homepage "http://www.tads.org/frobtads.htm"
  url "http://www.tads.org/frobtads/frobtads-1.2.3.tar.gz"
  sha256 "88c6a987813d4be1420a1c697e99ecef4fa9dd9bc922be4acf5a3054967ee788"

  head do
    url "https://github.com/realnc/frobtads.git"

    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "libtool" => :build
  end

  def install
    system "./bootstrap" if build.head?
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /FrobTADS #{version}$/, shell_output("#{bin}/frob --version")
  end
end
