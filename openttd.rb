class Openttd < Formula
  desc "Simulation game based upon Transport Tycoon Deluxe"
  homepage "https://www.openttd.org/"
  url "http://binaries.openttd.org/releases/1.6.1/openttd-1.6.1-source.tar.xz"
  sha256 "9b08996e31c3485ef8dedfa1ab65147091593f3f11bd51eb7662ce5ea41363aa"

  head "git://git.openttd.org/openttd/trunk.git"

  bottle do
    sha256 "623e1b5996dd8d1ad7bc203a091420dd03fc83fb8eb1434c518d3d8c25ad4f0a" => :el_capitan
    sha256 "45be2f0d892e64c969e6a16a298cfabc26f84cd59e20b3bd8a7d090edcce643a" => :yosemite
    sha256 "ae05e66f5cb1dc64a5f1dd2f6f9c809d02b0ab9f423548f543cbc125c8562cae" => :mavericks
  end

  depends_on "lzo"
  depends_on "xz"
  depends_on "pkg-config" => :build

  resource "opengfx" do
    url "https://bundles.openttdcoop.org/opengfx/releases/0.5.4/opengfx-0.5.4.zip"
    sha256 "3d136d776906dbe8b5df1434cb9a68d1249511a3c4cfaca55cc24cc0028ae078"
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
  patch :p0 do
    url "https://bugs.openttd.org/task/6380/getfile/10390/patch-src__video__cocoa__wnd_quartz.mm-avoid-removed-cmgetsystemprofile.diff"
    sha256 "2cf010eb69df588134aceda0eba62cc21e221b6f2dfb7d836869b6edf4bdc093"
  end
  patch :p1 do
    url "https://bugs.openttd.org/task/6380/getfile/10422/cocoa_m.patch"
    sha256 "cbd559318f653a2e7aaadad2fd7eb1097b24a68ad42cf417c4ca530b34d2a776"
  end

  def install
    system "./configure", "--prefix-dir=#{prefix}"
    system "make", "bundle"

    (buildpath/"bundle/OpenTTD.app/Contents/Resources/data/opengfx").install resource("opengfx")
    (buildpath/"bundle/OpenTTD.app/Contents/Resources/data/opensfx").install resource("opensfx")
    (buildpath/"bundle/OpenTTD.app/Contents/Resources/gm/openmsx").install resource("openmsx")

    prefix.install "bundle/OpenTTD.app"
    bin.write_exec_script "#{prefix}/OpenTTD.app/Contents/MacOS/openttd"
  end

  def caveats; <<-EOS.undent
      If you have access to the sound and graphics files from the original
      Transport Tycoon Deluxe, you can install them by following the
      instructions in section 4.1 of #{prefix}/readme.txt
    EOS
  end

  test do
    assert_match /OpenTTD #{version}\n/, shell_output("#{bin}/openttd -h")
  end
end
