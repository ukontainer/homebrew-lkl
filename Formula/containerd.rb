HOMEBREW_CTRD_REVISION="64291df71bff72e852188d17e5dad9f3c2c36024".freeze
HOMEBREW_CTRD_VERSION="beta3".freeze

class Containerd < Formula
  desc "Container daemon for macOS"
  homepage "https://github.com/containerd/containerd"
  url "https://github.com/containerd/containerd.git", revision: HOMEBREW_CTRD_REVISION
  version HOMEBREW_CTRD_VERSION
  # sha256 ""
  license ""

  depends_on "go" => :build

  # darwin mount call
  patch do
    url "https://github.com/ukontainer/containerd/commit/66c674690fc0dbfc01d7cd72ad9479877fe2e0a5.patch?full_index=1"
    sha256 "b05ba6eafa0cd5ff090bd593d55193a746f61624e4f4119f44ce849592c5d302"
  end
  # darwin snapshotter
  patch do
    url "https://github.com/ukontainer/containerd/commit/9fa4d24e5a69f4bbee0578d5b0a390f39d3d85de.patch?full_index=1"
    sha256 "74337b300f23de336faaefc65f300b9d79cfbb524359cac68fa94252e5e8f830"
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
