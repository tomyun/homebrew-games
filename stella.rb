class Stella < Formula
  desc "Atari 2600 VCS emulator"
  homepage "http://stella.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/stella/stella/4.6.5/stella-4.6.5-src.tar.gz"
  sha256 "7936a2755d029162df3ad45467d6fe4d026361c4ac51354102fa77953472e4e9"
  head "http://svn.code.sf.net/p/stella/code/trunk"

  bottle do
    cellar :any
    sha256 "4cf897a397322a5516933c24ca53612b9909b8bc566f1bc8bd7238241b440e8d" => :el_capitan
    sha256 "9315c8a4f91b0cb84096573b4a310246490462f9a48ec09edf927a4a63b3b467" => :yosemite
    sha256 "fae871ef923ff5e0221ae6d020836812936d784d9e230ddf1db8f386eb29999c" => :mavericks
  end

  depends_on :xcode => :build
  depends_on "sdl2"
  depends_on "libpng"

  def install
    cd "src/macosx" do
      inreplace "stella.xcodeproj/project.pbxproj" do |s|
        s.gsub! /(\w{24} \/\* SDL2\.framework)/, '//\1'
        s.gsub! /(\w{24} \/\* png)/, '//\1'
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
