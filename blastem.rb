class Blastem < Formula
  desc "Fast and accurate Genesis emulator"
  homepage "http://rhope.retrodev.com/files/blastem.html"
  url "http://rhope.retrodev.com/repos/blastem", :using => :hg, :revision => "c9ed929ee984"
  version "0.3.1"
  head "http://rhope.retrodev.com/repos/blastem"

  bottle do
    cellar :any
    sha256 "91409efedd7f6736faefe4bff23a99e2b49af3ae52b24311113cd76f7622e66d" => :el_capitan
    sha256 "f4e396fe0fe13554903d2186b7c81dd7bc9c372519adfc1196619be34e7f01a2" => :yosemite
    sha256 "d2786d311d8538275ea7155b818455c95601e316dc6c1fe335e655afa3b84755" => :mavericks
  end

  depends_on "pkg-config" => :build
  depends_on "glew"
  depends_on "sdl2"

  def install
    system "make"
    libexec.install %w[blastem default.cfg rom.db shaders]
    (bin/"blastem").write <<-EOS.undent
      #!/bin/sh
      exec "#{libexec}/blastem" "$@"
      EOS
  end

  test do
    assert_equal "blastem #{version}", shell_output("#{bin}/blastem -b 1 -v").chomp
  end
end
