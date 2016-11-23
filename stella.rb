class Stella < Formula
  desc "Atari 2600 VCS emulator"
  homepage "http://stella.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/stella/stella/4.7.3/stella-4.7.3-src.tar.xz"
  sha256 "93a75d1b343b1e66b6dc526c0f9d8a0c3678d346033f7cdfe76dc93f14d956ad"
  head "http://svn.code.sf.net/p/stella/code/trunk"

  bottle do
    cellar :any
    sha256 "bcd777a7560b4d58765a38395a294bda2524d388626061ce87d134c30ba2318c" => :el_capitan
    sha256 "c769d61077c74c403ff2d42fa205f25024e9dc592373ca41f8afa916b522bbb3" => :yosemite
    sha256 "6ed708874da3bdcac3562da763fabc2efaa7070c13addbc188bd95042df2e5a4" => :mavericks
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
