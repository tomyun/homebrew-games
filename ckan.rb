class MonoRequirement < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  desc "The Comprehensive Kerbal Archive Network"
  homepage "https://github.com/KSP-CKAN/CKAN/"
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.18.1/ckan.exe", :using => :nounzip
  version "1.18.1"
  sha256 "d9d45dec82e73a831afab755a078f3f099c8089053a21d6329088011ef76e572"

  bottle :unneeded

  depends_on MonoRequirement

  def install
    (libexec/"bin").install "ckan.exe"
    (bin/"ckan").write <<-EOS.undent
      #!/bin/sh
      exec mono "#{libexec}/bin/ckan.exe" "$@"
    EOS
  end

  test do
    system bin/"ckan", "version"
  end
end
