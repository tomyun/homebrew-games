class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20151015.tar.gz"
  sha256 "4c0186a2172e5414c86ee5792e68241a401fb6aa131fac75ee3992de37b198c9"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "8f356d57a3bba80e8a1d71c0341b17ca659e47ea4f952ce939a0b998989f96e4" => :el_capitan
    sha256 "642b00ccfd4fde699aaf2e03ea15dee7d43e1de53f27a8e9f61577635deae892" => :yosemite
    sha256 "665d6612aecf9a17c852994feded20a5babb5130f5e209e2a3d59d08158958e9" => :mavericks
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
