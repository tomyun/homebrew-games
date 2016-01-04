class Openttd < Formula
  desc "Simulation game based upon Transport Tycoon Deluxe"
  homepage "https://www.openttd.org/"
  url "https://binaries.openttd.org/releases/1.5.3/openttd-1.5.3-source.tar.xz"
  sha256 "d8b9a7aaca7c9f3ff69b1d210daf1e2658402941bb9b30cb2789a9df73d1ba63"
  revision 1

  head "git://git.openttd.org/openttd/trunk.git"

  bottle do
    sha256 "1aab1d07eaa620ff3a98aacee907dec1c83fa8ce87b0d56696cf46866fd8d39e" => :el_capitan
    sha256 "67c85299e9e83e08c458118f0186da507961a95dc18053d6b5a4842a23fe3151" => :yosemite
    sha256 "28c49c3ba4e506887d155cc066ab51ae2318c96dc89b31802b5fb94ba4b7cdee" => :mavericks
  end

  depends_on "lzo"
  depends_on "xz"
  depends_on "pkg-config" => :build

  resource "opengfx" do
    url "https://bundles.openttdcoop.org/opengfx/releases/0.5.3/opengfx-0.5.3.zip"
    sha256 "f744e3bafc27ee03703554128f8dd6d187858af486b0dcfe9570832028073220"
  end

  resource "opensfx" do
    url "https://bundles.openttdcoop.org/opensfx/releases/0.2.3/opensfx-0.2.3.zip"
    sha256 "3574745ac0c138bae53b56972591db8d778ad9faffd51deae37a48a563e71662"
  end

  resource "openmsx" do
    url "https://bundles.openttdcoop.org/openmsx/releases/0.3.1/openmsx-0.3.1.zip"
    sha256 "92e293ae89f13ad679f43185e83fb81fb8cad47fe63f4af3d3d9f955130460f5"
  end

  # Ensures a deployment target is not set on 10.9:
  # https://bugs.openttd.org/task/6295
  patch :p0 do
    url "https://trac.macports.org/export/117147/trunk/dports/games/openttd/files/patch-config.lib-remove-deployment-target.diff"
    sha256 "95c3d54a109c93dc88a693ab3bcc031ced5d936993f3447b875baa50d4e87dac"
  end

  # Fixes for 10.11
  # https://bugs.openttd.org/task/6380
  patch :DATA, :p1
  patch :p0 do
    url "https://bugs.openttd.org/task/6380/getfile/10390/patch-src__video__cocoa__wnd_quartz.mm-avoid-removed-cmgetsystemprofile.diff"
    sha256 "2cf010eb69df588134aceda0eba62cc21e221b6f2dfb7d836869b6edf4bdc093"
  end

  def install
    system "./configure", "--prefix-dir=#{prefix}"
    system "make", "bundle"

    (buildpath/"bundle/OpenTTD.app/Contents/Resources/data/opengfx").install resource("opengfx")
    (buildpath/"bundle/OpenTTD.app/Contents/Resources/data/opensfx").install resource("opensfx")
    (buildpath/"bundle/OpenTTD.app/Contents/Resources/gm/openmsx").install resource("openmsx")

    prefix.install "bundle/OpenTTD.app"
  end

  def caveats; <<-EOS.undent
      OpenTTD.app installed to: #{prefix}
      If you have access to the sound and graphics files from the original
      Transport Tycoon Deluxe, you can install them by following the
      instructions in section 4.1 of #{prefix}/readme.txt
    EOS
  end

  test do
    File.executable? prefix/"OpenTTD.app/Contents/MacOS/openttd"
  end
end

__END__
diff --git a/src/music/cocoa_m.cpp b/src/music/cocoa_m.cpp
index b0cb879..8818893 100644
--- a/src/music/cocoa_m.cpp
+++ b/src/music/cocoa_m.cpp
@@ -68,7 +68,7 @@ static void DoSetVolume()
			 * risk compilation errors. The header AudioComponent.h
			 * was introduced in 10.6 so use it to decide which
			 * type definition to use. */
-#ifdef __AUDIOCOMPONENT_H__
+#if defined(AUDIO_UNIT_VERSION) && (AUDIO_UNIT_VERSION >= 1060)
			AudioComponentDescription desc;
 #else
			ComponentDescription desc;
