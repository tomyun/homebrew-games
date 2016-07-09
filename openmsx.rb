class Openmsx < Formula
  desc "MSX emulator"
  homepage "http://openmsx.org/"
  url "https://github.com/openMSX/openMSX/releases/download/RELEASE_0_12_0/openmsx-0.12.0.tar.gz"
  sha256 "1d96a466badd625e7b6860a65afb10a7b5283a15721faa4186546693fec06a92"
  revision 1
  head "https://github.com/openMSX/openMSX.git"

  bottle do
    cellar :any
    sha256 "c113c29fd5bf9cd4defaf63103924f5f2c8f9809e1a86576e6730484b9889332" => :el_capitan
    sha256 "11e49a632940b61b5e06d02c1e5181ba14edbdf484e753b0486e290e1959cc74" => :yosemite
    sha256 "d229d035966c42b72f2b32e1273fc0119d9bf0550a89c37a7bef28b566e203ad" => :mavericks
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
