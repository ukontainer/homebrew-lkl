HOMEBREW_CTRD_REVISION="99987f2a5eae653c36a78f5258fd5369766cebcf".freeze
HOMEBREW_CTRD_VERSION="beta2".freeze

class Containerd < Formula
  desc "Container daemon for macOS"
  homepage "https://github.com/containerd/containerd"
  url "https://github.com/containerd/containerd.git", revision: HOMEBREW_CTRD_REVISION
  version HOMEBREW_CTRD_VERSION
  # sha256 ""
  license ""

  depends_on "go" => :build

  patch do
    url "https://github.com/containerd/containerd/commit/0c3484d793b31f0030d1c2426fc16cb14b9e9b00.patch?full_index=1"
    sha256 "8112375f80e2679f6a2fb0d2df13f98a5e736663a8e15348b4ca4523e373e0ea"
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
    system "false"
  end
end
