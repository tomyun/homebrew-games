class Dolphin < Formula
  desc "Nintendo GameCube and Wii emulator"
  homepage "https://dolphin-emu.org/"
  url "https://github.com/dolphin-emu/dolphin/archive/5.0-rc.tar.gz"
  version "5.0rc"
  sha256 "8f4a6e715e9687eb0d1d52f35c3ea65ee80950121d514bb78365c51db3af41a7"
  head "https://github.com/dolphin-emu/dolphin.git"

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "gettext" => :build
  depends_on "ffmpeg" => :recommended
  depends_on "portaudio" => :recommended
  depends_on "enet" => :optional
  depends_on "lzo" => :recommended
  depends_on "libpng" => :recommended
  depends_on "sdl2" => :optional
  depends_on "libusb" => :recommended
  depends_on "sfml" => :recommended
  depends_on "miniupnpc" => :recommended
  #depends_on "polarssl" => :recommended
  depends_on "qt5" => :optional
  depends_on "wxmac" => :recommended

  def install
    ENV.deparallelize

    #cd "Externals" do
      #rm_rf ["LZO", "libpng", "portaudio", "wxWidgets3", "zlib", "GL", "OpenAL", "SFML", "gettext", "libiconv-1.14", "libusb", "miniupnpc", "polarssl"]
      #rm_rf ["LZO", "libpng", "portaudio", "wxWidgets3", "zlib", "OpenAL", "SFML", "gettext", "libiconv-1.14", "libusb", "miniupnpc"]
    #end
    # Prevent include conflict
    rm_rf "Externals/LZO"

    args = std_cmake_args
    args << "-DUSE_SHARED_ENT=ON" if build.with? "enet"
    args << "-DDISABLE_WX=ON" if build.without? "wxmac"
    args << "-DENABLE_QT=ON" if build.with? "qt5"
    args << "-DENABLE_SDL=ON" if build.with? "sdl2"
    args << "-DOSX_USE_DEFAULT_SEARCH_PATH=ON"
    args << "-DSKIP_POSTPROCESS_BUNDLE=ON"

    inreplace "CMakeLists.txt",
              #/(if\(\.*)\s*(?:AND)?\s*(?:NOT APPLE)\s*(?:AND)?\s*(.*\n\s*(?:check_lib|find_package|include)\((?:LZO|PNG|SFML|FindMiniupnpc|FindPolarSSL))/,
              /(if\(\.*)\s*(?:AND)?\s*(?:NOT APPLE)\s*(?:AND)?\s*(.*\n\s*(?:check_lib|find_package|include)\((?:LZO|PNG|SFML|FindMiniupnpc))/,
              '\1 \2'

    mkdir "Build" do
      system "cmake", "..", *args
      system "make"
      cd "Binaries" do
        # Make sure data files are copied to bundle
        rm_rf "Dolphin.app/Contents/Resources/Sys"
        cp_r "../../Data/Sys", "Dolphin.app/Contents/Resources"
        prefix.install "Dolphin.app"
        bin.write_exec_script "#{prefix}/Dolphin.app/Contents/MacOS/Dolphin"
      end
    end
  end

  test do
    assert_match /Usage: Dolphin/, shell_output("#{bin}/dolphin -h 2>&1", 255)
  end
end
