HOMEBREW_CTRD_REVISION="feature-darwin-build".freeze
HOMEBREW_CTRD_VERSION="beta2".freeze

class Nerdctl < Formula
  desc "Docker-compatible CLI for containerd for macOS"
  homepage "https://github.com/containerd/nerdctl"
  url "https://github.com/ukontainer/nerdctl.git", branch: HOMEBREW_CTRD_REVISION
  version HOMEBREW_CTRD_VERSION
  # sha256 ""
  license ""

  depends_on "go" => :build

  def install
    system "make"
    bin.install "_output/nerdctl"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test nerdctl`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end
