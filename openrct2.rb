class Openrct2 < Formula
  desc "Open source re-implementation of RollerCoaster Tycoon 2"
  homepage "https://openrct2.website"
  url "https://github.com/OpenRCT2/OpenRCT2/archive/v0.0.4.tar.gz"
  sha256 "ebcbbf1de3ccb76168535308ec9045271fae6c730bca4929575277f98deb40ab"

  head do
    url "https://github.com/OpenRCT2/OpenRCT2.git", :branch => "develop"

    depends_on "openssl" => "universal"
  end

  depends_on "cmake" => :build
  depends_on "pkg-config" => :build
  depends_on "jansson" => "universal"
  depends_on "libpng" => "universal"
  depends_on "sdl2" => "universal"
  depends_on "sdl2_ttf" => "universal"
  depends_on "speex" => "universal"

  depends_on "freetype" => "universal" # for sdl2_ttf
  depends_on "libogg" => "universal" # for speex
  depends_on "xz" => "universal" # for libpng

  def install
    ENV.m32
    mkdir "build" do
      system "cmake", "..", *std_cmake_args
      system "make", "install"
    end

    # By default OS X build only looks up data in app bundle Resources
    libexec.install bin/"openrct2"
    (bin/"openrct2").write <<-EOS.undent
      #!/bin/bash
      exec "#{libexec}/openrct2" "$@" "--openrct-data-path=#{pkgshare}"
      EOS
  end

  test do
    assert_match /OpenRCT2, v#{version}/, shell_output("#{bin}/openrct2 -v")
  end
end
