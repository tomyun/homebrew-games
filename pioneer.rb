class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160225.tar.gz"
  sha256 "bcecb8c1c1a448ac76c8890be24d8758d22604be64c8f9b771bf8d3aefcbd8b2"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "b0fcd30fb0b5b2f7adc22494f036075bf19f240bff6be880ff7eee20700bc221" => :el_capitan
    sha256 "4e0d9b7e73a5119a0d424e9ec2e14567a0631b72fe62a7413ae09d3fc7c04421" => :yosemite
    sha256 "745c5a2144b934c673f52514ca84bf9e54e6e8e0398950fbef59d9ef927e3516" => :mavericks
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
