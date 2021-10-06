class ContainerdOld < Formula
  desc "Container daemon for macOS (old version)"
  homepage "https://github.com/ukontainer/containerd"
  url "https://github.com/ukontainer/containerd.git", branch: "old-darwin-native-snap"
  # sha256 ""
  version "alpha"
  license ""

  depends_on "go" => :build

  def install
    system "make"
    bin.install "bin/containerd"
    bin.install "bin/containerd-shim"
    bin.install "bin/ctr"
  end
end
