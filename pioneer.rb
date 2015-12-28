class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151221.tar.gz"
  sha256 "78c7cd4effe7c0062d7a19d4dbc8a03f7f4cdb476868ae79d66bae8c79033404"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "f9e802ead4296c18af32ee34936e0e9498b44371eefeca0acb9e2aa4ee7d841d" => :el_capitan
    sha256 "2673af7e3fc120930afc543ad02baa7094662dc8940f07e378493803fb1ff380" => :yosemite
    sha256 "a01e9c93bb1576142a8debcd3b49db2eeb7a75d8b61276ec0c64f6b011f5bd4f" => :mavericks
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
