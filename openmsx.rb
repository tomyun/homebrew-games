class Openmsx < Formula
  desc "MSX emulator"
  homepage "http://openmsx.org/"
  url "https://github.com/openMSX/openMSX/releases/download/RELEASE_0_12_0/openmsx-0.12.0.tar.gz"
  sha256 "1d96a466badd625e7b6860a65afb10a7b5283a15721faa4186546693fec06a92"
  revision 1
  head "https://github.com/openMSX/openMSX.git"

  bottle do
    cellar :any
    sha256 "1aae521eede398ab57dedadb80ddeb505da5fedb065a555998ac2496dee9a2c5" => :el_capitan
    sha256 "4022509c77a9cce2e54638625b5000274decc7c46314b9c96fd9e1a8a37cd0ab" => :yosemite
    sha256 "4c06b663debabd9dde61495eb23ffc30d8dbec5e042e73dc1d5405df5d05e71b" => :mavericks
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
