class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160814.tar.gz"
  sha256 "51fe5dbe8aefa4810d0c1b4db5d739fe2dee2fceb1f4956de5173cc83148f0c3"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "8293da4bb9bc35a214a488d5ac4ef01378cbb614e327e6b0cd5c0039eb29d996" => :el_capitan
    sha256 "92e05d567a1730c3cd715256d436c769e589bf7e532a95460864b4072eb7c47a" => :yosemite
    sha256 "7df6a8d8bd98fcfedc516fb23323e55208adac2ac3e972e19c3d9529a7f5704c" => :mavericks
  end

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "pkg-config" => :build
  depends_on "assimp"
  depends_on "freetype"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "libsigc++"
  depends_on "libvorbis"
  depends_on "libpng"
  depends_on "lua"

  needs :cxx11

  def install
    ENV.cxx11
    ENV["PIONEER_DATA_DIR"] = "#{pkgshare}/data"
    system "./bootstrap"
    system "./configure", "--disable-dependency-tracking",
                          "--disable-silent-rules",
                          "--prefix=#{prefix}",
                          "--with-version=#{version}",
                          "--with-external-liblua"
    system "make", "install"
  end

  test do
    assert_equal "#{name} #{version}", shell_output("#{bin}/pioneer -v 2>&1").chomp
    assert_equal "modelcompiler #{version}", shell_output("#{bin}/modelcompiler -v 2>&1").chomp
  end
end
