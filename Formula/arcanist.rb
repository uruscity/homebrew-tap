# Originally taken from http://github.com/homebrew/homebrew-php and carefully updated
#
class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2019-08-22/1.tar.gz"
    sha256 "6a5f726870224da8cf18d904bb96a1a6d8ee25d31c27ff8a0d2093884c243887"
    version "201908221"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2020-02-13/1.tar.gz"
      sha256 "8a08c155f17a6a34c88ca23185e2b1506aa53a01a099e35fc6e9487c02340e4c"
      version "202002131"
    end
  end

  head do
    url "https://github.com/phacility/arcanist.git"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil.git"
    end
  end

  depends_on 'php'

  def install
    libexec.install Dir["*"]

    resource("libphutil").stage do
      (buildpath/"libphutil").install Dir["*"]
    end

    prefix.install Dir["*"]

    bin.install_symlink libexec/"bin/arc" => "arc"

    cp libexec/"resources/shell/bash-completion", libexec/"resources/shell/arc-completion.zsh"
    bash_completion.install libexec/"resources/shell/bash-completion" => "arc"
    zsh_completion.install libexec/"resources/shell/arc-completion.zsh" => "_arc"
  end

  test do
    system "#{bin}/arc", "help"
  end
end
