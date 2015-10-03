class GnuChess < Formula
  desc "GNU Chess"
  homepage "https://www.gnu.org/software/chess/"
  url "http://ftpmirror.gnu.org/chess/gnuchess-6.2.1.tar.gz"
  mirror "https://ftp.gnu.org/gnu/chess/gnuchess-6.2.1.tar.gz"
  sha256 "17caab725539447bcb17a14b17905242cbf287087e53a6777524feb7bbaeed06"

  bottle do
    revision 1
    sha256 "ab0dfd8e6bacd19fb100cb5437b6f08067ecc192b9c171dd1005cae48e65e640" => :el_capitan
    sha256 "23fc1f5b14c6c18350726102838be7cbaaa323ebfa1d73c6ce2533efa5757a49" => :yosemite
    sha256 "e037d039dda8b7660aabe72277ac563cceae5d4dd38a9eb9c9c9eaa9e3ddec48" => :mavericks
  end

  head do
    url "svn://svn.savannah.gnu.org/chess/trunk"
    depends_on "autoconf" => :build
    depends_on "automake" => :build
    depends_on "help2man" => :build
    depends_on "gettext"
  end

  option "with-book", "Download the opening book (~25MB)"

  resource "book" do
    url "http://ftpmirror.gnu.org/chess/book_1.02.pgn.gz"
    sha256 "deac77edb061a59249a19deb03da349cae051e52527a6cb5af808d9398d32d44"
  end

  def install
    if build.head?
      system "autoreconf", "--install"
      chmod 0755, "install-sh"
    end

    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"

    if build.with? "book"
      resource("book").stage do
        doc.install "book_1.02.pgn"
      end
    end
  end

  if build.with? "book"
    def caveats; <<-EOS.undent
      This formula also downloads the additional opening book.  The
      opening book is a PGN file located in #{doc} that can be added
      using gnuchess commands.
    EOS
    end
  end

  test do
    assert_equal "GNU Chess #{version}", shell_output("#{bin}/gnuchess --version").chomp
  end
end
