# Originally taken from http://github.com/homebrew/homebrew-php and carefully updated
#
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2019-05-08/1.tar.gz"
    sha256 "dfa7208ca7438a8f98a0162f3ec50a90a9b9b24eff5f721b9c1850b27d923c6b"
    version "201905081"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2019-05-08/1.tar.gz"
      sha256 "3aba80e69efd756e7c53966c9ff017c823c707923613a82e0ae91fbc78307dc4"
      version "201905081"
    end
  end

  head do
    url "https://github.com/phacility/arcanist.git"

    resource "libphutil" do
      url "https://github.com/phacility/libphutil.git"
    end
  end

  depends_on PhpMetaRequirement

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
