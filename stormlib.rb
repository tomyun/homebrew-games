class Stormlib < Formula
  desc "Library for handling Blizzard MPQ archives"
  homepage "http://www.zezula.net/en/mpq/stormlib.html"
  url "https://github.com/ladislav-zezula/StormLib/archive/v9.20.tar.gz"
  sha256 "fdfc7d0b444cd5d540c5732155a7c5011c573e90029947198f651aec93db4887"

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
    system "cmake", "CMakeLists.txt", "-DWITH_STATIC=YES", *std_cmake_args
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
    assert_equal "#{version}", shell_output("./test")
  end
end

__END__
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3b22069..03ed2c6 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -288,7 +288,6 @@ if(WITH_STATIC)
 endif()

 if(APPLE)
-    set_target_properties(storm PROPERTIES FRAMEWORK true)
     set_target_properties(storm PROPERTIES PUBLIC_HEADER "src/StormLib.h src/StormPort.h")
     set_target_properties(storm PROPERTIES LINK_FLAGS "-framework Carbon")
 endif()
