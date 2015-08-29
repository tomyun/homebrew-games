class Stella < Formula
  desc "Atari 2600 VCS emulator"
  homepage "http://stella.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/stella/stella/4.6.1/stella-4.6.1-src.tar.gz"
  sha256 "c1921671dbc08422ae8a7a4102c6a2a34433f04594d67f55a7129c1504bcd288"
  head "http://svn.code.sf.net/p/stella/code/trunk"

  bottle do
    cellar :any
    sha256 "d03cfaf52ddde28e64af20c41154c3784889b080abe9abc59d8392f596502a73" => :yosemite
    sha256 "ae0b69db944de4763d432633da62af711e179a39cf777333237a92fa36fbe4c4" => :mavericks
    sha256 "17c207be83ef5afafe5e8fb2dd8b6af78858453a55e61dcecdf9b961e0cd8909" => :mountain_lion
  end

  depends_on :xcode => :build
  depends_on "sdl2"
  depends_on "libpng"

  def install
    cd "src/macosx" do
      inreplace "stella.xcodeproj/project.pbxproj" do |s|
        s.gsub! %r[(\w{24} /\* SDL2\.framework)], '//\1'
        s.gsub! %r[(\w{24} /\* png)], '//\1'
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
