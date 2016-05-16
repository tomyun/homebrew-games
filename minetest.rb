class Minetest < Formula
  desc "Free, open source voxel game engine and game"
  homepage "http://www.minetest.net/"

  stable do
    url "https://github.com/minetest/minetest/archive/0.4.14.tar.gz"
    sha256 "203de4d41a60466126ab92ca85f726d88d0084f2e78393da239e7416cb847054"

    resource "minetest_game" do
      url "https://github.com/minetest/minetest_game/archive/0.4.14.tar.gz"
      sha256 "eebc2830d0e2f431f648691a0072fbb773d000c56deaf09ddc5e7416096cdf85"
    end
  end

  bottle do
    sha256 "4b57e57833b5b75a0a8f65821e69db26f9ba9b428649e9e6522a6a0469d1a3c1" => :yosemite
    sha256 "1c75b811f352ca4f5b145346de12b2a70017144e8ac9c286b08cde4b9b4f1b6d" => :mavericks
    sha256 "de66cf4c04ae23893eddbcc2d7fd30cc968825822fe1c7771d7429662bffd500" => :mountain_lion
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
