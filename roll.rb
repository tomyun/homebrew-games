class Roll < Formula
  desc "CLI program for rolling a dice sequence"
  homepage "http://matteocorti.ch/software/roll.html"
  url "http://matteocorti.ch/software/roll/roll-2.0.2.tar.gz"
  sha256 "15b3fb5fe43c61799da3e15574aec4fb414e30e7bfda3b1e4a3b4b398a3a99a9"
  head do
    url "svn://svn.code.sf.net/p/roll/code/trunk/roll"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
  end

  def install
    system "./regen.sh" if build.head?
    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/roll", "1d6"
  end
end
