class MonoRequirement < Requirement
  fatal true
  default_formula "mono"
  satisfy { which("mono") }
end

class Ckan < Formula
  desc "The Comprehensive Kerbal Archive Network"
  homepage "https://github.com/KSP-CKAN/CKAN/"
  url "https://github.com/KSP-CKAN/CKAN/releases/download/v1.14.3/ckan.exe", :using => :nounzip
  version "1.14.3"
  sha256 "4fb28aec82e6d7f48b3326aac5dd875a94a37e089803dd3af385b4f501faab4f"

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
