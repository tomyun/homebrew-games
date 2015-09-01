class Supertux < Formula
  desc "Classic 2D jump'n run sidescroller game"
  homepage "https://supertux.github.io/"

  stable do
    url "https://github.com/SuperTux/supertux/releases/download/v0.1.3/supertux-0.1.3.tar.bz2"
    sha256 "0092588351776626955339caaa62d12ce5954bb80c5f6952f60a122f53c2ad97"

    depends_on "sdl"
    depends_on "sdl_image"
    depends_on "sdl_mixer" => "with-libvorbis"
  end

  devel do
    url "https://github.com/SuperTux/supertux/releases/download/v0.3.5a/supertux-0.3.5a.tar.bz2"
    sha256 "71c34502b5879a4130fb111ac754967c3a632ef3017f30883a4d496d87bef8c7"

    depends_on "cmake" => :build
    depends_on "pkg-config" => :build
    depends_on "boost" => :build
    depends_on "sdl2"
    depends_on "sdl2_image"
    depends_on "sdl2_mixer" => "with-libvorbis"
    depends_on "libogg"
    depends_on "libvorbis"
    depends_on "physfs"
    depends_on "glew"

    needs :cxx11
  end

  def install
    if build.stable?
      # https://trac.macports.org/ticket/29635
      inreplace "src/menu.h", /Menu::(get_controlfield_key_into_input)/, '\1'
      system "./configure", "--disable-dependency-tracking",
                            "--with-apple-opengl-framework",
                            "--prefix=#{prefix}"
      system "make", "install"
      (share/"applications").rmtree
      (share/"pixmaps").rmtree
    else
      ENV.cxx11
      # Prevent build failure on Mavericks
      inreplace "src/supertux/screen_manager.hpp", /.*\(Action &a\)[^}]+}/, ""
      system "cmake", ".", *std_cmake_args
      system "make", "install"
      bin.write_exec_script "#{prefix}/SuperTux.app/Contents/MacOS/supertux2"
      (share/"appdata").rmtree
    end
  end

  test do
    if stable?
      (testpath/".supertux/config").write ""
      assert_match /SuperTux #{version}/, shell_output("#{bin}/supertux --version")
    else
      assert_equal "supertux2 #{version}", shell_output("#{bin}/supertux2 --version").chomp
    end
  end
end
