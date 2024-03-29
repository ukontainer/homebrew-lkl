HOMEBREW_CTRD_REVISION="60703af9fdf113eb41520df7f5f17e5e831a83c1".freeze
HOMEBREW_CTRD_VERSION="beta5".freeze

class Containerd < Formula
  desc "Container daemon for macOS"
  homepage "https://github.com/containerd/containerd"
  url "https://github.com/containerd/containerd.git", revision: HOMEBREW_CTRD_REVISION
  version HOMEBREW_CTRD_VERSION
  # sha256 ""
  license ""

  bottle do
    root_url "https://github.com/ukontainer/homebrew-lkl/releases/download/containerd-beta5"
    sha256 cellar: :any_skip_relocation, big_sur:  "92579b9ed36b9c1d8aaa88d298cc151066849b6918adcc02996457b7615279ab"
    sha256 cellar: :any_skip_relocation, catalina: "536ced30e8c0b396fceb2b5f8b9922f9487467386b17f687aadfdf46b66724f5"
  end

  depends_on "go" => :build
  depends_on "ukontainer/lkl/darwin-snapshotter"

  # darwin mount call
  patch do
    url "https://github.com/ukontainer/containerd/commit/190b8b350994559b36cb47a5e48aabed9cc95f20.patch?full_index=1"
    sha256 "6fe455cf113b9ce5de4af8fc603d06a72aadbe7bb13bd1b8ea61dabc50173805"
  end

  def install
    system "make"
    bin.install "bin/containerd"
    bin.install "bin/containerd-shim"
    bin.install "bin/ctr"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test containerd`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
