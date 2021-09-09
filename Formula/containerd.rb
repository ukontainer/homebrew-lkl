# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
HOMEBREW_CTRD_REVISION="99987f2a5eae653c36a78f5258fd5369766cebcf".freeze
HOMEBREW_CTRD_VERSION="beta2".freeze

class Containerd < Formula
  desc "Container daemon for macOS"
  homepage "https://github.com/containerd/containerd"
  url "https://github.com/containerd/containerd.git", :revision => HOMEBREW_CTRD_REVISION
  version "#{HOMEBREW_CTRD_VERSION}"
  sha256 ""
  license ""

  depends_on "go" => :build

  patch do
    url "https://patch-diff.githubusercontent.com/raw/containerd/containerd/pull/5935.diff"
    sha256 "b8a200b40c8a1f9dbd21a500b675ab988aaff131b359425c2d319ec331c2db6f"
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    # https://rubydoc.brew.sh/Formula.html#std_configure_args-instance_method
    system "make"
    bin.install "bin/containerd"
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
