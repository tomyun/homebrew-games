class GnuChess < Formula
  desc "GNU Chess"
  homepage "https://www.gnu.org/software/chess/"
  url "https://ftpmirror.gnu.org/chess/gnuchess-6.2.3.tar.gz"
  mirror "https://ftp.gnu.org/gnu/chess/gnuchess-6.2.3.tar.gz"
  sha256 "78999176b2f2b5e0325bcc69749b7b2cefb7b1ef4f02d101fa77ae24a1b31b82"

  bottle do
    sha256 "0579b3ce42325c257768bb3a2ce38644aa29c4ac618ba0b072c622a80db47fa2" => :el_capitan
    sha256 "9ea09f5202304f6c039497fb28079f08e1e3bcced67b0ad27abe8ec4fe73c182" => :yosemite
    sha256 "d527d8baf9d9b4cd0c4d89fbb0775884f215c993de769e6c07a5bb4accdcb7fa" => :mavericks
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
