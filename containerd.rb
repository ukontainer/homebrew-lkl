HOMEBREW_CTRD_BRANCH="runu-darwin-master-190607".freeze
HOMEBREW_CTRD_VERSION="beta1".freeze

class Containerd < Formula
  desc "Container daemon for macOS"
  homepage "https://github.com/ukontainer/containerd"
  url "https://github.com/ukontainer/containerd.git", :branch => HOMEBREW_CTRD_BRANCH
  version "#{HOMEBREW_CTRD_BRANCH}-#{HOMEBREW_CTRD_VERSION}"
  head "https://github.com/ukontainer/containerd.git", :branch => HOMEBREW_CTRD_BRANCH

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/containerd/"
    ln_sf buildpath, buildpath/"src/github.com/containerd/containerd"
    system "cd src/github.com/containerd/containerd && make"
    bin.install "src/github.com/containerd/containerd/bin/containerd"
    bin.install "src/github.com/containerd/containerd/bin/containerd-shim"
    bin.install "src/github.com/containerd/containerd/bin/ctr"
  end

  test do
    system "false"
  end
end
