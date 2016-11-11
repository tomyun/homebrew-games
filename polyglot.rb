class Polyglot < Formula
  desc "Protocol adapter to run UCI engines under XBoard"
  homepage "https://chessprogramming.wikispaces.com/PolyGlot"
  url "http://hgm.nubati.net/releases/polyglot-2.0.4.tar.gz"
  sha256 "c11647d1e1cb4ad5aca3d80ef425b16b499aaa453458054c3aa6bec9cac65fc1"
  head "http://hgm.nubati.net/git/polyglot.git", :branch => "learn"

  def install
    system "./configure", "--prefix=#{prefix}"
    system "make", "install"
  end

  test do
    assert_match /^PolyGlot \d\.\d\.[0-9a-z]+ by Fabien Letouzey/, shell_output("#{bin}/polyglot --help")
  end
end
