class Mupen64plusVideoGlide64mk2 < Formula
  desc "Video plugin for Mupen64Plus 2.0"
  homepage "http://www.mupen64plus.org/"
  url "https://github.com/mupen64plus/mupen64plus-video-glide64mk2/releases/download/2.5/mupen64plus-video-glide64mk2-src-2.5.tar.gz"
  sha256 "ef3dae0084e078d843605abdf5039eb8b5dd68ff1410b4fc12bdf19592a9fcb6"

  depends_on "pkg-config" => :build
  depends_on "libpng"
  depends_on "sdl"
  depends_on "boost"
  depends_on "mupen64plus"

  def install
    system "make", "install", "-C", "projects/unix",
                              "PREFIX=#{prefix}",
                              "C_INCLUDE_PATH=/usr/local/include",
                              "CPLUS_INCLUDE_PATH=/usr/local/include",
                              "V=1"
  end
end
