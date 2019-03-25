# Originally taken from http://github.com/homebrew/homebrew-php and carefully updated
#
require File.expand_path("../../Requirements/php-meta-requirement", __FILE__)

class Arcanist < Formula
  desc "Phabricator Arcanist Tool"
  homepage "https://secure.phabricator.com/book/phabricator/article/arcanist/"

  stable do
    url "https://github.com/wikimedia/arcanist/archive/release/2019-03-20/1.tar.gz"
    sha256 "c0cf6ccebb89add3bae8e41904af402738aa05867da1ff65d9cdd3b0af1ed8df"
    version "201903201"

    resource "libphutil" do
      url "https://github.com/wikimedia/phabricator-libphutil/archive/release/2019-03-20/1.tar.gz"
      sha256 "2a014378dfc1811f441b2b01be88148ad4ff8bb4102383725555acd5871cbe70"
      version "201903201"
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
