class Robotfindskitten < Formula
  desc "Zen Simulation of robot finding kitten"
  homepage "http://robotfindskitten.org/"
  url "https://downloads.sourceforge.net/project/rfk/robotfindskitten-POSIX/mayan_apocalypse_edition/robotfindskitten-2.7182818.701.tar.gz"
  sha256 "7749a370796fd23e3b306b00de5f7fb7997a35fef30e3910ff159448c932d719"

  def install
    system "./configure", "--disable-dependency-tracking",
                          "--prefix=#{prefix}"
    system "make", "install", "execgamesdir=#{bin}"
  end

  test do
    assert_equal "robotfindskitten: #{version}",
      shell_output("#{bin}/robotfindskitten -V").chomp
  end
end
