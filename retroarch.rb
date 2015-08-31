class Retroarch < Formula
  desc "Official frontend for libretro"
  homepage "http://www.libretro.com/"
  url "https://github.com/libretro/RetroArch/archive/v1.2.2.tar.gz"
  sha256 "1113f75f6ddb790174b0f9e0fc82ff4875e8a4d39262428a6ba4a931a147b9af"

  resource "cg" do
    url "http://developer.download.nvidia.com/cg/Cg_3.1/Cg-3.1_April2012.dmg"
    sha256 "85c7a0de82252b703191fee5fe7b29f60d357924dc7b8ca59c2badeac7af407d"
  end

  depends_on "pkg-config" => :build
  depends_on "p7zip" => :build
  depends_on "sdl"
  depends_on "libxml2"
  depends_on "freetype"
  depends_on "ffmpeg" => :recommended
  #depends_on "libusb"
  #depends_on :x11

  def install
    resource("cg").stage do
      #mkdir "M"
      #system "hdiutil", "attach", "Cg-3.1_April2012.dmg", "-mountpoint", "M", "-nobrowse"
      #system "tar", "xzf", "M/Cg-3.1.0013.app/Contents/Resources/Installer Items/NVIDIA_Cg.tgz"
      #cp_r "Library/Frameworks/Cg.framework", "#{buildpath}"
      #system "hdiutil", "detach", "M"
      system "7z", "x", "Cg-3.1_April2012.dmg"
      system "7z", "x", "2.hfsx"
      system "tar", "xzf", "Cg-3.1.0013/Cg-3.1.0013.app/Contents/Resources/Installer Items/NVIDIA_Cg.tgz"
      #mkdir "#{buildpath}/apple/Frameworks"
      cp_r "Library/Frameworks", "#{buildpath}/apple/Frameworks"
    end
    #system "./configure", "--prefix=#{prefix}",
    #                      "--global-config-dir=#{pkgshare}"
    #system "make"
    #system "make", "install"
    inreplace "apple/RetroArch.xcodeproj/project.pbxproj" do |s|
      s.gsub! /(FRAMEWORK_SEARCH_PATHS) = \(/, "\\1 = ( #{buildpath}/apple/Frameworks,"
      s.gsub! %r{/Library/Frameworks/(Cg\.framework)}, "#{buildpath}/apple/Frameworks/\\1"
      s.gsub! %r{((?:\.\./)+)(System/Library/Frameworks/)}, '/\2' 
    end
    cd "apple" do
      #xcodebuild "-target", "RetroArch", "-configuration", "Release", "-project", "RetroArch.xcodeproj"
      xcodebuild "-configuration", "Release"
      (buildpath/"apple/build/Release/RetroArch.app/Contents/Frameworks").install "Frameworks/Cg.framework"
      prefix.install "build/Release/RetroArch.app"
      bin.write_exec_script "#{prefix}/RetroArch.app/Contents/MacOS/RetroArch"
    end
  end

  test do
    system "false"
  end
end
