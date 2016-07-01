class Pioneer < Formula
  desc "Game of lonely space adventure"
  homepage "http://pioneerspacesim.net/"
  url "https://github.com/pioneerspacesim/pioneer/archive/20160701.tar.gz"
  sha256 "35cd925c7a61a62f1630c6f11e667659efa28c569285fe99eedcda1aefb39f11"
  head "https://github.com/pioneerspacesim/pioneer.git"

  bottle do
    sha256 "9887914575ea2b4880427de7c141fb3d438d88660fb5d7804a6b3ae7c0148b9c" => :el_capitan
    sha256 "ed0cad5d561c9c53bb93f1a3645f461b03b513a6c2d01f45284ca5d7aa59e65b" => :yosemite
    sha256 "47cd6064734be4ee0872d9ab948aa4a5b6aaabcfe086ef42e5379c98b116f9ac" => :mavericks
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
