class Hexgui < Formula
  desc "GUI for playing Hex over Hex Text Protocol"
  homepage "https://sourceforge.net/p/benzene/hexgui/"
  url "https://github.com/apetresc/hexgui/archive/v0.9.1.tar.gz"
  sha256 "7ed1af209617ad2e4877e5f46b4ba78eced14f94fa581b65ac3111abc7613c08"
  head "https://github.com/apetresc/hexgui.git"

  depends_on :ant => :build
  depends_on :java => "1.6+"

  def install
    system "ant"
    libexec.install Dir["*"]
    (bin/"hexgui").write_env_script libexec/"bin/hexgui", Language::Java.java_home_env("1.6+")
  end

  test do
    assert_match /^HexGui #{version} .*/, shell_output("#{bin}/hexgui -version").chomp
  end
end
