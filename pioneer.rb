class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160724.tar.gz"
  sha256 "3e4ad503df35a938b0de3c90a2fce02b392e3b323e1a4f509008c398f6078374"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "72242d1c116cdbb9ac7cb3f33197a9e0f9194362d7b4fe1e95a8adc1b499df44" => :el_capitan
    sha256 "8de2fb63620d21f6dd14adad5047e052352e9cf743cb041f9c18cff046640360" => :yosemite
    sha256 "4d1a5eee98e495327bddba6fb9c7b25a5353270502837b33776fb61406c0eb41" => :mavericks
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
