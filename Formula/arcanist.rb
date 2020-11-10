# Originally taken from http://github.com/homebrew/homebrew-php and carefully updated
#
class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/phacility/arcanist/archive/ac54d61d7af20f5d65ba889974f23a86bfb6cd57.tar.gz"
    sha256 "d6edfccd857edf5e67df57a8019aa3c4cb9560dd48a93b1ddbe308fb546dc49c"
    version "202010191"
  end

  head do
    url "https://github.com/phacility/arcanist.git"
  end

  depends_on 'php'

  def install
    libexec.install Dir["*"]

    prefix.install Dir["*"]

    bin.install_symlink libexec/"bin/arc" => "arc"
  end

  test do
    system "#{bin}/arc", "help"
  end
end
