class Pytouhou < Formula
  desc "Libre implementation of Touhou 6 engine"
  homepage "http://pytouhou.linkmauve.fr/"
  url "http://hg.linkmauve.fr/touhou", :revision => "5270c34b4c00", :using => :hg
  version "634"
  head "http://hg.linkmauve.fr/touhou", :using => :hg

  option "with-demo", "Install demo version of Touhou 6"

  depends_on :python3
  depends_on "pkg-config" => :build
  depends_on "libepoxy"
  depends_on "sdl2"
  depends_on "sdl2_image"
  depends_on "sdl2_mixer"
  depends_on "sdl2_ttf"
  depends_on "gtk+3" => :recommended
  if build.with? "gtk+3"
    depends_on "py3cairo" # FIXME: didn't get picked up by pygobject3 below
    depends_on "pygobject3" => "with-python3"
  end

  resource "cython" do
    url "https://pypi.python.org/packages/source/C/Cython/Cython-0.23.3.tar.gz"
    sha256 "590274ac8dbd1e62cc79d94eb2e2f4ae60cea91a9f8d50b8697d39aba451e82e"
  end

  resource "demo" do
    url "http://www16.big.or.jp/~zun/data/soft/kouma_tr013.lzh"
    sha256 "77ea64ade20ae7d890a4b0b1623673780c34dd2aa48bf2410603ade626440a8b"
  end

  def install
    pyver = Language::Python.major_minor_version "python3"
    ENV.prepend_create_path "PYTHONPATH", libexec/"vendor/lib/python#{pyver}/site-packages"
    resource("cython").stage do
      system "python3", *Language::Python.setup_install_args(libexec/"vendor")
    end

    # hg can't determine revision number (no .hg on the stage)
    inreplace "setup.py", /(version)=.+,$/, "\\1='#{version}',"
    ENV.prepend_create_path "PYTHONPATH", libexec/"lib/python#{pyver}/site-packages"
    system "python3", *Language::Python.setup_install_args(libexec)

    resource("demo").stage do
      (pkgshare/"game").install Dir["東方紅魔郷　体験版/*"]
    end if build.with? "demo"

    # Set default game path to pkgshare
    inreplace "#{libexec}/bin/pytouhou", /('path'): '\.'/, "\\1: '#{pkgshare}/game'"

    bin.install Dir[libexec/"bin/*"]
    bin.env_script_all_files(libexec/"bin", :PYTHONPATH => ENV["PYTHONPATH"])
  end

  def caveats
    s = <<-EOS.undent
    The default path for the game data is:
      #{pkgshare}/game
    EOS
    if build.with? "demo"
      s += <<-EOS.undent
      Demo version of Touhou 6 has been installed.
      EOS
    end
    s
  end
end
