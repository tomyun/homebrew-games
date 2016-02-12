class Mkxp < Formula
  desc "RPG Maker XP/VX/VX Ace games interpreter"
  homepage "https://github.com/Ancurio/mkxp"
  url "https://github.com/Ancurio/mkxp.git", :revision => "5d776319b56473f564c1230116b096b01699c260"
  version "0+20160104"
  head "https://github.com/Ancurio/mkxp.git"

  depends_on "autoconf" => :build
  depends_on "automake" => :build
  depends_on "cmake" => :build
  depends_on "libtool" => :build
  depends_on "pkg-config" => :build
  depends_on "qt" => :build

  depends_on "boost"
  depends_on "fluid-synth" => :optional
  depends_on "libogg"
  depends_on "libsigc++"
  depends_on "libvorbis"
  depends_on "openal-soft"
  depends_on "pixman"
  depends_on "homebrew/versions/ruby22" # failed to build with 2.3
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_ttf"

  needs :cxx11

  # not available in the core
  resource "libguess" do
    url "https://github.com/kaniini/libguess.git", :revision => "b44a240c57ddce98f772ae7d9f2cf11a5972d8c2"
  end

  # requires latest version (2.1)
  resource "physfs" do
    url "https://hg.icculus.org/icculus/physfs/", :revision => "50b6cb7b3f4b", :using => :hg
  end

  # requires forked version
  resource "sdl_sound" do
    url "https://github.com/Ancurio/SDL_sound.git", :revision => "ab6539a4697d6d8a2729138168e97eed4fdedc41"
  end

  def install
    ENV.cxx11

    ENV.prepend "CFLAGS", "-I#{libexec}/include"
    ENV.prepend "LDFLAGS", "-L#{libexec}/lib"
    ENV.prepend_create_path "PKG_CONFIG_PATH", "#{libexec}/lib/pkgconfig"

    resource("libguess").stage do
      system "./autogen.sh"
      system "./configure", "--prefix=#{libexec}"
      system "make"
      system "make", "install"
    end

    resource("physfs").stage do
      # force installing pkg-config file
      inreplace "CMakeLists.txt", "NOT APPLE", "APPLE"
      mkdir "macbuild" do
        args = std_cmake_args
        args << "-DCMAKE_INSTALL_PREFIX:PATH=#{libexec}"
        args << "-DPHYSFS_BUILD_TEST=FALSE"
        system "cmake", "..", *args
        system "make", "install"
      end
    end

    resource("sdl_sound").stage do
      inreplace "bootstrap", "/usr/bin/glibtoolize", "#{Formula["libtool"].opt_bin}/glibtoolize"
      system "./bootstrap"
      system "./configure", "--prefix=#{libexec}"
      system "make", "install"
    end

    system "qmake", "CONFIG+=INI_ENCODING", "DEFINES+=WORKDIR_CURRENT", "MRIVERSION=2.2"
    system "make"
    prefix.install "mkxp.app"
    bin.write_exec_script "#{prefix}/mkxp.app/Contents/MacOS/mkxp"

    # homebrew can't manage to do this
    system "install_name_tool", "-change", "libphysfs.1.dylib", "#{libexec}/lib/libphysfs.1.dylib", "#{prefix}/mkxp.app/Contents/MacOS/mkxp"
  end
end
