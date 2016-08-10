class Pioneers < Formula
  desc "Settlers of Catan clone"
  homepage "http://pio.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/pio/Source/pioneers-15.3.tar.gz"
  sha256 "69afa51b71646565536b571b0f89786d3a7616965265f196fd51656b51381a89"

  bottle do
    sha256 "a730bdf002bfda9e19d76cab2bd872781d924c34dca6b1cd64bc065a4d40dc42" => :yosemite
    sha256 "2e65d1c08371fa63383c24bf1c9e11985ba9fe34399a32d9ce7ff60e865db106" => :mavericks
    sha256 "6082e96d27afc23b1962db0d4b668ebf6b212a887c40dd437bfada8af9d4e8c4" => :mountain_lion
  end

  fails_with :clang do
    build 318
    cause "'#line directive requires a positive integer' argument in generated file"
  end

  depends_on "pkg-config" => :build
  depends_on "intltool" => :build
  depends_on "gettext"
  depends_on "gtk+3"
  depends_on "librsvg" # svg images for gdk-pixbuf

  def install
    # fix usage of echo options not supported by sh
    inreplace "Makefile.in", /\becho/, "/bin/echo"

    # GNU ld-only options
    inreplace Dir["configure{,.ac}"] do |s|
      s.gsub!(/ -Wl\,--as-needed/, "")
      s.gsub!(/ -Wl,-z,(relro|now)/, "")
    end

    system "./configure", "--disable-debug", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    system "#{bin}/pioneers-editor", "--help"
    server = fork do
      system "#{bin}/pioneers-server-console"
    end
    sleep 5
    Process.kill("TERM", server)
  end
end
