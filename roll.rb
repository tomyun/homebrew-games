class Roll < Formula
  desc "CLI program for rolling a dice sequence"
  homepage "https://matteocorti.github.io/roll/"
  url "https://github.com/matteocorti/roll/releases/download/v2.1.1/roll-2.1.1.tar.gz"
  sha256 "5d499c690d30cbe93dc571eb8e3f11d1505ce4595c8151646777548ef89a7997"

  bottle do
    cellar :any_skip_relocation
    sha256 "ce7f741763e5a382bebe1faf1497e52c3c67250b517bdad146303f2eef3c1087" => :el_capitan
    sha256 "1f2b9ca1560c7cef7b8872a035700af3d34a9ed5a171aaf31fd2b28352de79e7" => :yosemite
    sha256 "0fa1adec68a257fb086eedc345658d569a931809517590183c36e98e93087814" => :mavericks
  end

  head do
    url "https://github.com/matteocorti/roll.git"
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
