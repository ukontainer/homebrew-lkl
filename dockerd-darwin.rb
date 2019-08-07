require 'formula'

HOMEBREW_DOCKERD_BRANCH='darwin-port'
HOMEBREW_DOCKERD_VERSION='beta'
class DockerdDarwin < Formula
  desc "Moby Project - a collaborative project for the container ecosystem to assemble container-based systems"
  homepage "https://github.com/ukontainer/dockerd-darwin"
  url 'https://github.com/ukontainer/dockerd-darwin.git', :branch => HOMEBREW_DOCKERD_BRANCH
  version "#{HOMEBREW_DOCKERD_BRANCH}-#{HOMEBREW_DOCKERD_VERSION}"
  head "https://github.com/ukontainer/dockerd-darwin.git", :branch => HOMEBREW_DOCKERD_BRANCH
  
  depends_on 'go' => :build
  depends_on 'ukontainer/lkl/containerd'

  def install
      ENV['GOPATH'] = buildpath
      mkdir_p buildpath/'src/github.com/docker/'
      ln_sf buildpath, buildpath/'src/github.com/docker/docker'
      system 'cd src/github.com/docker/docker && make -f Makefile.darwin'
      bin.install Dir['src/github.com/docker/docker/bundles/dynbinary-daemon/*']
  end
end
