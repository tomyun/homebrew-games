class Blastem < Formula
  desc "Fast and accurate Genesis emulator"
  homepage "http://rhope.retrodev.com/files/blastem.html"
  url "http://rhope.retrodev.com/repos/blastem/archive/1ffa7891b4ec.tar.gz"
  version "0.4.1"
  sha256 "f9a15d2e381c7eb6f55f12b0d00f3d2779b0b29bea99b422484d6ada250655ba"
  head "http://rhope.retrodev.com/repos/blastem", :using => :hg

  bottle do
    cellar :any
    sha256 "91409efedd7f6736faefe4bff23a99e2b49af3ae52b24311113cd76f7622e66d" => :el_capitan
    sha256 "f4e396fe0fe13554903d2186b7c81dd7bc9c372519adfc1196619be34e7f01a2" => :yosemite
    sha256 "d2786d311d8538275ea7155b818455c95601e316dc6c1fe335e655afa3b84755" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "homebrew/python/pillow" => :build
  depends_on "libpng" => :build # for xcftools
  depends_on "glew"
  depends_on "sdl2"

  resource "vasm" do
    url "http://server.owl.de/~frank/tags/vasm1_7e.tar.gz"
    sha256 "2878c9c62bd7b33379111a66649f6de7f9267568946c097ffb7c08f0acd0df92"
  end

  resource "xcftools" do
    url "http://henning.makholm.net/xcftools/xcftools-1.0.7.tar.gz"
    sha256 "1ebf6d8405348600bc551712d9e4f7c33cc83e416804709f68d0700afde920a6"
  end

  def install
    resource("vasm").stage do
      system "make", "CPU=m68k", "SYNTAX=mot"
      (buildpath/"tool").install "vasmm68k_mot"
    end

    # FIXME: xcftools is not in the core tap
    # https://github.com/Homebrew/homebrew-core/pull/1216
    resource("xcftools").stage do
      # Apply patch to build with libpng-1.5 or above
      # http://anonscm.debian.org/cgit/collab-maint/xcftools.git/commit/?id=c40088b82c6a788792aae4068ddc8458de313a9b
      inreplace "xcf2png.c", /png_(voidp|error_ptr)_NULL/, "NULL"

      system "./configure"

      # Avoid `touch` error from empty MANLINGUAS when building without NLS
      ENV.deparallelize
      touch "manpo/manpages.pot"
      system "make", "manpo/manpages.pot"

      system "make"
      (buildpath/"tool").install "xcf2png"
    end

    ENV.prepend_path "PATH", buildpath/"tool"

    system "make", "menu.bin"
    system "make"
    libexec.install %w[blastem default.cfg menu.bin rom.db shaders]
    bin.write_exec_script libexec/"blastem"
  end

  test do
    assert_equal "blastem #{version}", shell_output("#{bin}/blastem -b 1 -v").chomp
  end
end
