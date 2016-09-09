class Widelands < Formula
  desc "Free real-time strategy game like Settlers II."
  homepage "https://wl.widelands.org/"
  url "https://launchpad.net/widelands/build18/build-18/+download/widelands-build18-src.tar.bz2"
  sha256 "6dffd9178f93ff7a9c3c0c9b31b7d3b8eb060c79fbd98901e6311837390b7de3"

  bottle do
    cellar :any
    sha256 "37a4e3d7eeb33a963f8ed568abe488df666385d5d8514fda4403dfc5939882c1" => :el_capitan
    sha256 "da07952c61c3ff0a67eeb534754203e75cb31639d0335d30a28a3d17d908cd6f" => :yosemite
    sha256 "618b7837413b5eb81be71f6db038e11e9c30436aee5450dcc167bd60e966e15c" => :mavericks
  end

  depends_on "cmake" => :build
  depends_on "boost"
  depends_on "libpng"
  depends_on "minizip"
  depends_on "gettext"
  depends_on "sdl_image"
  depends_on "sdl_mixer"
  depends_on "sdl_net"
  depends_on "sdl_ttf"
  depends_on "sdl_gfx"
  depends_on "doxygen"
  depends_on "glew"
  depends_on "lua51"

  def install
    if File.exist?("#{HOMEBREW_PREFIX}/lib/liblua.dylib")
      odie <<-EOS.undent
        Please do "brew unlink lua && brew unlink lua53" while installing Widelands.
        And you may do "brew link lua && brew link lua53" after installing Widelands.
      EOS
    end

    ENV.append "CPPFLAS", "-I#{Formula["lua51"].opt_include}/lua-5.1"
    ENV.append "LDFLAGS", "-L#{Formula["lua51"].opt_lib}"

    cd "build" do
      system "cmake", "..", "-DLUA_INCLUDE_DIR:PATH=#{Formula["lua51"].opt_include}/lua-5.1",
                      "-DLUA_LIBRARIES:STRING=#{Formula["lua51"].opt_lib}/liblua.5.1.dylib",
                      "-DLUA_LIBRARY:FILEPATH=#{Formula["lua51"].opt_lib}/liblua.5.1.dylib",
                      # Without the following option, Cmake intend to use the library of MONO framework.
                      "-DPNG_PNG_INCLUDE_DIR:PATH=#{Formula["libpng"].opt_include}",
                      "-DWL_INSTALL_DATADIR=#{pkgshare}/data", "-DWL_INSTALL_BINDIR=#{libexec}", *std_cmake_args
      system "make", "install"
      (bin/"widelands").write <<-EOS.undent
        #!/bin/sh
        exec #{libexec}/widelands --datadir=#{pkgshare}/data "$@"
      EOS
    end
  end

  test do
    system libexec/"widelands", "--version"
  end
end
