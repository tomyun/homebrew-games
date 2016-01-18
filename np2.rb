class Np2 < Formula
  desc "Neko Project 2: PC-9801 emulator"
  homepage "http://www.yui.ne.jp/np2/"
  url "http://amethyst.yui.ne.jp/svn/pc98/np2/tags/VER_0_85/", :using => :svn, :revision => "2408"
  head "http://amethyst.yui.ne.jp/svn/pc98/np2/trunk/", :using => :svn

  bottle do
    cellar :any
    sha256 "85c39c15387e6b5dabd7c72ab9228cb14d24fa43d5336ed77b96400f50a04cff" => :el_capitan
    sha256 "34a7f3ade2995062e35f2ed08a6c4bc49af1e46c36865a6c279a4c5a5044b2ba" => :yosemite
    sha256 "6bafaf81c147591598249b1a8a1829614d2b436fcd07a5d8019e958f51d0d9a5" => :mavericks
  end

  depends_on :xcode => :build
  depends_on "sdl2"
  depends_on "sdl2_ttf"

  def install
    sdl2 = Formula["sdl2"]
    sdl2_ttf = Formula["sdl2_ttf"]

    cd "sdl2/MacOSX" do
      # Use brewed library paths
      inreplace "np2sdl2.xcodeproj/project.pbxproj" do |s|
        s.gsub! "BAF84E4B195AA35E00183062", "//BAF84E4B195AA35E00183062"
        s.gsub! "HEADER_SEARCH_PATHS = (", "LIBRARY_SEARCH_PATHS = (\"$(inherited)\", #{sdl2.lib}, #{sdl2_ttf.lib}); HEADER_SEARCH_PATHS = (#{sdl2.include}/SDL2, #{sdl2.include}, #{sdl2_ttf.include},"
        s.gsub! "buildSettings = {", 'buildSettings ={ OTHER_LDFLAGS = "-lSDL2 -lSDL2_ttf";'
      end
      # Force to use Japanese TTF font
      inreplace "np2sdl2/compiler.h", "#define RESOURCE_US", ""
      # Always use current working directory
      inreplace "np2sdl2/main.m", "[pstrBundlePath UTF8String]", '"./"'

      xcodebuild "SYMROOT=build"
      bin.install "build/Release/np2sdl2.app/Contents/MacOS/np2sdl2" => "np2"
    end
  end

  def caveats; <<-EOS.undent
    A Japanese TTF file named `default.ttf` should be in the working directory.
    EOS
  end

  test do
    assert_match /Usage: #{bin}\/np2/, shell_output("#{bin}/np2 -h", 1)
  end
end
