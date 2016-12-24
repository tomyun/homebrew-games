class Minetest < Formula
  desc "Free, open source voxel game engine and game"
  homepage "http://www.minetest.net/"

  stable do
    url "https://github.com/minetest/minetest/archive/0.4.15.tar.gz"
    sha256 "5684e6118e3484f8901323f1ca4179202659010b33c72f02bc03df792493e3a9"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game/archive/0.4.15.tar.gz"
      sha256 "f583ea55f511bbcc106c60f7d488ec3fe6b961efc3fd648603b6acd0189d7d8a"
    end
  end

  bottle do
    sha256 "f3ba3ebf2ac234d8d6961b7b9449ccfb798f10987807506c313f9a45436674f3" => :el_capitan
    sha256 "48f55279a5aa5f8d6736ef8a0863041d0d4cd34b8fc0e9a827d4fc2870c910e5" => :yosemite
    sha256 "adea2ef1899a13ffae1cda55b4a116ab2ec614969cbb3d45f8cfb18102cbbbfb" => :mavericks
  end

  head do
    url "https://github.com/minetest/minetest.git"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game.git", :branch => "master"
    end
  end

  depends_on :x11
  depends_on "cmake" => :build
  depends_on "irrlicht"
  depends_on "jpeg"
  depends_on "libogg"
  depends_on "libvorbis"
  depends_on "luajit" => :recommended
  depends_on "freetype" => :recommended
  depends_on "gettext" => :recommended
  depends_on "leveldb" => :optional
  depends_on "redis" => :optional

  def install
    (buildpath/"games/minetest_game").install resource("minetest_game")

    args = std_cmake_args - %w[-DCMAKE_BUILD_TYPE=None]
    args << "-DCMAKE_BUILD_TYPE=Release" << "-DBUILD_CLIENT=1" << "-DBUILD_SERVER=0"
    args << "-DENABLE_REDIS=1" if build.with? "redis"
    args << "-DENABLE_LEVELDB=1" if build.with? "leveldb"
    args << "-DENABLE_FREETYPE=1" << "-DCMAKE_EXE_LINKER_FLAGS='-L#{Formula["freetype"].opt_lib}'" if build.with? "freetype"
    args << "-DENABLE_GETTEXT=1" << "-DCUSTOM_GETTEXT_PATH=#{Formula["gettext"].opt_prefix}" if build.with? "gettext"

    # -ffast-math compiler flag is an issue on Mac
    # https://github.com/minetest/minetest/issues/4274
    inreplace "src/CMakeLists.txt", "-ffast-math", ""

    system "cmake", ".", *args
    system "make", "package"
    system "unzip", "minetest-*-osx.zip"
    prefix.install "minetest.app"
  end

  def caveats; <<-EOS.undent
      Put additional subgames and mods into "games" and "mods" folders under
      "~/Library/Application Support/minetest/", respectively (you may have
      to create those folders first).

      If you would like to start the Minetest server from a terminal, run
      "/Applications/minetest.app/Contents/MacOS/minetest --server".
    EOS
  end
end
