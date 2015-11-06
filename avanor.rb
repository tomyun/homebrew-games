class Avanor < Formula
  desc "Quick-growing roguelike game with easy ADOM-like UI"
  homepage "http://avanor.sourceforge.net/"
  url "https://downloads.sourceforge.net/project/avanor/avanor/0.5.8/avanor-0.5.8-src.tar.bz2"
  sha256 "8f55be83d985470b9a5220263fc87d0a0a6e2b60dbbc977c1c49347321379ef3"

  # Upstream fix for clang: http://sourceforge.net/p/avanor/code/133/
  patch :p0 do
    url "https://gist.githubusercontent.com/mistydemeo/64f47233ee64d55cb7d5/raw/c1847d7e3a134e6109ad30ce1968919dd962e727/avanor-clang.diff"
    sha256 "2d24ce7b71eb7b20485d841aabffa55b25b9074f9a5dd83aee33b7695ba9d75c"
  end

  def install
    system "make", "DATA_DIR=#{share}/avanor/", "CC=#{ENV.cxx}", "LD=#{ENV.cxx}"
    bin.install "avanor"
    (share/"avanor").install "manual"
  end

  test do
    script = (testpath/"script.exp")
    script.write <<-EOS.undent
      #!/usr/bin/expect -f
      set timeout 10
      spawn avanor
      send -- "\e"
      expect eof
    EOS
    script.chmod 0700
    system "./script.exp"
  end
end
