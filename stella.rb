class Stella < Formula
  desc "Atari 2600 VCS emulator"
  homepage "http://stella.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/stella/stella/4.7.2/stella-4.7.2-src.tar.xz"
  sha256 "b2727a0e2d3b112d35dcb89b4bdc789e2c7f15e9d9c7054a69a2f67facd7416e"
  head "http://svn.code.sf.net/p/stella/code/trunk"

  bottle do
    cellar :any
    sha256 "6fd09cb8a090fafe459cf714a100cf5384af672b283f2139e5311a72a858b95c" => :el_capitan
    sha256 "9dac10f70ab7aaf007c50bb117635245d3417c789dc4cbfcfa6d4ea55f2ea511" => :yosemite
    sha256 "b41c484685bfb8209c0c1f9172e69829fa52f3e709c4173d1b4b5d8797e30830" => :mavericks
  end

  depends_on :xcode => :build
  depends_on "sdl2"
  depends_on "libpng"

  def install
    cd "src/macosx" do
      inreplace "stella.xcodeproj/project.pbxproj" do |s|
        s.gsub! %r{(\w{24} \/\* SDL2\.framework)}, '//\1'
        s.gsub! %r{(\w{24} \/\* png)}, '//\1'
        s.gsub! /(HEADER_SEARCH_PATHS) = \(/, "\\1 = (#{Formula["sdl2"].include}/SDL2, #{Formula["libpng"].include},"
        s.gsub! /(LIBRARY_SEARCH_PATHS) = \.;/, "\\1 = (#{Formula["sdl2"].lib}, #{Formula["libpng"].lib}, .);"
        s.gsub! /(OTHER_LDFLAGS) = "((-\w+)*)"/, '\1 = "-lSDL2 -lpng \2"'
      end
      xcodebuild "SYMROOT=build"
      prefix.install "build/Default/Stella.app"
      bin.write_exec_script "#{prefix}/Stella.app/Contents/MacOS/Stella"
    end
  end

  test do
    assert_match /Stella version #{version}/, shell_output("#{bin}/Stella -help").strip
  end
end
