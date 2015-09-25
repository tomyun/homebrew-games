class Blastem < Formula
  desc "Fast and accurate Genesis emulator"
  homepage "http://rhope.retrodev.com/files/blastem.html"
  url "http://rhope.retrodev.com/repos/blastem", :using => :hg, :revision => "c9ed929ee984"
  version "0.3.1"
  head "http://rhope.retrodev.com/repos/blastem"

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
