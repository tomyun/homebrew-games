class MonoRequirement < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  desc "The Comprehensive Kerbal Archive Network"
  homepage "https://github.com/KSP-CKAN/CKAN/"
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.14.0/ckan.exe", :using => :nounzip
  version "1.14.0"
  sha256 "bb777b3c8fc689255b0a176bdbdb22cbd9ef523102298d1becea7fa9c49a4f66"

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
