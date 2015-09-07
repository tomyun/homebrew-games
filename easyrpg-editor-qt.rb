class EasyrpgEditorQt < Formula
  desc "RPG Maker 2000/2003 games editor"
  homepage "https://easy-rpg.org/"
  head "https://github.com/EasyRPG/Editor-Qt.git"

  depends_on "pkg-config" => :build
  depends_on "qt5"
  depends_on "liblcf"

  needs :cxx11

  def install
    ENV.cxx11
    system "#{Formula["qt5"].bin}/qmake", "PREFIX=#{prefix}", "QT_CONFIG-=no-pkg-config", "CONFIG+=c++11"
    system "make"
    prefix.install "bin/easyrpg-editor.app"
    bin.write_exec_script "#{prefix}/easyrpg-editor.app/Contents/MacOS/easyrpg-editor"
  end

  test do
    File.executable? "#{prefix}/easyrpg-editor.app/Contents/MacOS/easyrpg-editor"
  end
end
