class MonoRequirement < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  desc "The Comprehensive Kerbal Archive Network"
  homepage "https://github.com/KSP-CKAN/CKAN/"
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.16.1/ckan.exe", :using => :nounzip
  version "1.16.1"
  sha256 "7e74a885a54cad145401476296a2cbdc531ce5c7e383f52fe7719000f40947fc"

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
