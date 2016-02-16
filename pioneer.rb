class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160214.tar.gz"
  sha256 "898cbf6dc4c021601df3e2fba99ad555b887a189b6d23ff0a7a101f10b46d3e4"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "ae3768ad7395b8dec6a0cbad870f6e6de2ecb900239d9f40216cef85b0fc8396" => :el_capitan
    sha256 "55ff3553feb3e24f537a282fd60f8947ea426375f13df885c3c1b4fcc735f7ca" => :yosemite
    sha256 "93fbdd383dd11d75cec8990ceffd6ea496b923f80c11eafb406c6078606fb395" => :mavericks
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
  end
end
