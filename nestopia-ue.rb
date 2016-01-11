class NestopiaUe < Formula
  desc "Nestopia UE (Undead Edition): NES emulator"
  homepage "http://0ldsk00l.ca/nestopia/"
  url "https://downloads.sourceforge.net/project/nestopiaue/1.47/nestopia-1.47.tgz"
  sha256 "84624d30ab05d609db2734db0065616b268f79d4aa35f1cd90cb35ee8d96be0c"
  head "https://github.com/rdanbrook/nestopia.git"

  bottle do
    sha256 "9852d20c03254c4c3e9334964c8399fd44d1973354f87d3d455650786b6ff241" => :el_capitan
    sha256 "9399ebc23978e10e1537f6f81dbf72211f2e0dccb38eb539ca29e7d8f800c501" => :yosemite
    sha256 "fab88c6bbac83497a82058af1197f81b4cfd2e271c715e31be4cf9628d0d4e07" => :mavericks
  end

  depends_on "sdl2"
  depends_on "libao"
  depends_on "libarchive"
  depends_on "libepoxy"

  def install
    system "make", "PREFIX=#{prefix}", "DATADIR=#{pkgshare}"
    bin.install "nestopia"
    pkgshare.install "NstDatabase.xml"
  end

  test do
    assert_match /Nestopia UE #{version}$/, shell_output("#{bin}/nestopia --version")
  end
end
