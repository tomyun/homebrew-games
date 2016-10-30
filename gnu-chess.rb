class GnuChess < Formula
  desc "GNU Chess"
  homepage "https://www.gnu.org/software/chess/"
  url "https://ftpmirror.gnu.org/chess/gnuchess-6.2.4.tar.gz"
  mirror "https://ftp.gnu.org/gnu/chess/gnuchess-6.2.4.tar.gz"
  sha256 "3c425c0264f253fc5cc2ba969abe667d77703c728770bd4b23c456cbe5e082ef"

  bottle do
    sha256 "f7731b8842de23c097aeef912bae3cc7741ac4cbc38991360a8f4d78038bedb3" => :sierra
    sha256 "f34008093bf9470ad06e1ffc3babed7bf4c54d05d94b27cb650ea8650420b773" => :el_capitan
    sha256 "c8986b5cb7ae044196e2e83e9fb004c741146d433526883a0e0e4646cbe88dfb" => :yosemite
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
    url "https://ftpmirror.gnu.org/chess/book_1.02.pgn.gz"
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
