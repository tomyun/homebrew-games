class Stormlib < Formula
  desc "Library for handling Blizzard MPQ archives"
  homepage "http://www.zezula.net/en/mpq/stormlib.html"
  url "https://github.com/ladislav-zezula/StormLib/archive/v9.21.tar.gz"
  sha256 "e23e9f106c6367f161fc63e015e7da6156b261b14c7e4a5aa542df02009294f9"
  head "https://github.com/ladislav-zezula/StormLib.git"

  bottle do
    cellar :any
    sha256 "16962abbd9b652af114a43b56794d27760be1568fac7a391a698b6b12e697aef" => :el_capitan
    sha256 "08d13e6ba1811b7716cb633ea4e13d6bf037af05878efcb01672c51d6241376c" => :yosemite
    sha256 "9ca69941525fdf438fd604601b39a23c1918791393ea465626c3db1705c3f305" => :mavericks
  end

  depends_on "cmake" => :build

  # prevents cmake from trying to write to /Library/Frameworks/
  patch :DATA

  def install
    system "cmake", ".", *std_cmake_args
    system "make", "install"
    system "cmake", ".", "-DBUILD_SHARED_LIBS=ON", *std_cmake_args
    system "make", "install"
  end

  test do
    (testpath/"test.c").write <<-EOS.undent
      #include <stdio.h>
      #include <StormLib.h>

      int main(int argc, char *argv[]) {
        printf("%s", STORMLIB_VERSION_STRING);
        return 0;
      }
    EOS
    system ENV.cc, "-o", "test", "test.c"
    assert_equal version.to_s, shell_output("./test")
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 76c6aa9..4fd0a46 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -297,7 +297,6 @@ target_include_directories(${LIBRARY_NAME} PUBLIC src/)
 set_target_properties(${LIBRARY_NAME} PROPERTIES PUBLIC_HEADER "src/StormLib.h;src/StormPort.h")
 if(BUILD_SHARED_LIBS)
     if(APPLE)
-        set_target_properties(${LIBRARY_NAME} PROPERTIES FRAMEWORK true)
         set_target_properties(${LIBRARY_NAME} PROPERTIES LINK_FLAGS "-framework Carbon")
     endif()
     if(UNIX)
