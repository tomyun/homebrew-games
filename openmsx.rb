class Openmsx < Formula
  desc "MSX emulator"
  homepage "http://openmsx.org/"
  url "https://github.com/openMSX/openMSX/releases/download/RELEASE_0_12_0/openmsx-0.12.0.tar.gz"
  sha256 "1d96a466badd625e7b6860a65afb10a7b5283a15721faa4186546693fec06a92"
  head "https://github.com/openMSX/openMSX.git"

  bottle do
    cellar :any
    sha256 "7152747329d9aff212d66c1a22898fc3d9e113a049f6ba888b7c87bac93405cc" => :yosemite
    sha256 "25265b5bbe38716ab2147c05cd412ffb1e7f202db2eedcba2bc338611217ff19" => :mavericks
    sha256 "ae9fa8361ffca294c613d15fdf614409242a34ddeea940a5874dbfaef4295425" => :mountain_lion
  end

  option "without-opengl", "Disable OpenGL post-processing renderer"
  option "with-laserdisc", "Enable Laserdisc support"

  depends_on "sdl"
  depends_on "sdl_ttf"
  depends_on "freetype"
  depends_on "libpng"
  depends_on "glew" if build.with? "opengl"

  if build.with? "laserdisc"
    depends_on "libogg"
    depends_on "libvorbis"
    depends_on "theora"
  end

  def install
    inreplace "build/custom.mk", "/opt/openMSX", prefix
    # Help finding Tcl
    inreplace "build/libraries.py", /\((distroRoot), \)/, "(\\1, '/usr', '#{MacOS.sdk_path}/usr')"
    system "./configure"
    system "make"
    prefix.install Dir["derived/**/openMSX.app"]
    bin.write_exec_script "#{prefix}/openMSX.app/Contents/MacOS/openmsx"
  end

  test do
    system "#{bin}/openmsx", "-testconfig"
  end
end
