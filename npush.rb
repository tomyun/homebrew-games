class Npush < Formula
  desc "Logic game simliar to Sokoban and Boulder Dash"
  homepage "http://npush.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/npush/npush/0.7/npush-0.7.tgz"
  sha256 "f216d2b3279e8737784f77d4843c9e6f223fa131ce1ebddaf00ad802aba2bcd9"
  head "svn://svn.code.sf.net/p/npush/code/"

  def install
    system "make"
    pkgshare.install ["npush", "levels"]
    (bin/"npush").write <<-EOS.undent
      #!/bin/sh
      cd "#{pkgshare}" && exec ./npush $@
      EOS
  end
end
