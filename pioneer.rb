class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160907.tar.gz"
  sha256 "89c981d7f0d2bc8876b1bea8437dfea53a95de0ab2b207a24f63fbee1fff3b28"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "36b0b1bdbba81d2d82c9e9d174c9df52c07923793deb7c616d81c38bd9f6b305" => :el_capitan
    sha256 "b80842ff8e68b88e8d8527d51f5c328a56e3e3d92ec68072cdcc3931f46ceae3" => :yosemite
    sha256 "fb9a8325c6009ae1cd19b1446bec32f02caf30277b59935c8a3fedc2bd0cc374" => :mavericks
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
