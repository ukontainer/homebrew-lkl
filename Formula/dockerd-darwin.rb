HOMEBREW_DOCKERD_BRANCH="darwin-port".freeze
HOMEBREW_DOCKERD_VERSION="beta1".freeze

class DockerdDarwin < Formula
  desc "Docker daemon for macOS"
  homepage "https://github.com/ukontainer/dockerd-darwin"
  url "https://github.com/ukontainer/dockerd-darwin.git", branch: HOMEBREW_DOCKERD_BRANCH
  version "#{HOMEBREW_DOCKERD_BRANCH}-#{HOMEBREW_DOCKERD_VERSION}"
  head "https://github.com/ukontainer/dockerd-darwin.git", branch: HOMEBREW_DOCKERD_BRANCH

  depends_on "go" => :build
  depends_on "ukontainer/lkl/containerd"

  def install
    ENV["GOPATH"] = buildpath
    mkdir_p buildpath/"src/github.com/docker/"
    ln_sf buildpath, buildpath/"src/github.com/docker/docker"
    system "cd src/github.com/docker/docker && GO111MODULE=off make -f Makefile.darwin"
    bin.install "src/github.com/docker/docker/bundles/dynbinary-daemon/dockerd"
    bin.install "src/github.com/docker/docker/bundles/dynbinary-daemon/dockerd-dev"
  end

  test do
    system "false"
  end
end
