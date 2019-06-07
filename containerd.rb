require 'formula'

HOMEBREW_CTRD_BRANCH='runu-darwin-master-190607'
HOMEBREW_CTRD_VERSION='beta'
class Containerd < Formula
  homepage 'https://github.com/ukontainer/containerd'
  url 'https://github.com/ukontainer/containerd.git', :branch => HOMEBREW_CTRD_BRANCH
  version "#{HOMEBREW_CTRD_BRANCH}-#{HOMEBREW_CTRD_VERSION}"
  head 'https://github.com/ukontainer/containerd.git', :branch => HOMEBREW_CTRD_BRANCH

  depends_on 'go' => :build

  def install
    ENV['GOPATH'] = buildpath
    system 'go', 'get', 'github.com/opencontainers/runtime-spec/specs-go'
    system 'go', 'get', 'github.com/urfave/cli'
    system 'go', 'get', 'github.com/sirupsen/logrus'
    system 'go', 'get', 'github.com/opencontainers/runc/libcontainer/specconv'
    mkdir_p buildpath/'src/github.com/containerd/'
    ln_sf buildpath, buildpath/'src/github.com/containerd/containerd'
    system 'cd src/github.com/containerd/containerd && make'
    bin.install Dir['src/github.com/containerd/containerd/bin/*']
  end
end
