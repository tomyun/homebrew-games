class Fizmo < Formula
  desc "Z-Machine interpreter"
  homepage "https://christoph-ender.de/fizmo/"
  url "https://christoph-ender.de/fizmo/source/fizmo-0.7.10.tar.gz"
  sha256 "0e3561492ece58ff60eba768f3b2cfa943ba111736b0f63b775e3face590462b"

  depends_on "pkg-config" => :build
  depends_on :x11
  depends_on "jpeg"
  depends_on "libpng"
  depends_on "libsndfile"
  depends_on "sdl2"

  def install
    ENV["ncursesw_CFLAGS"] = "-I#{MacOS.sdk_path}/usr/include"
    ENV["ncursesw_LIBS"] = "-L#{MacOS.sdk_path}/usr/lib -lncurses"
    system "./configure", "--prefix=#{prefix}",
                          "--disable-dependency-tracking",
                          "--disable-silent-rules"
    system "make", "install"
  end

  test do
    assert_match /libfizmo version #{version}\.$/, shell_output("#{bin}/fizmo-console --help")
  end
end
