HOMEBREW_VERSION="1.0".freeze

class DarwinSnapshotter < Formula
  desc "Snapshotter plugin for conatined/macOS"
  homepage "https://github.com/ukontainer/darwin-snapshotter"
  url "https://github.com/ukontainer/darwin-snapshotter.git", tag: "v#{HOMEBREW_VERSION}"
  # sha256 ""
  license ""

  bottle do
    root_url "https://github.com/ukontainer/homebrew-lkl/releases/download/darwin-snapshotter-1.0"
    sha256 cellar: :any_skip_relocation, big_sur: "18f7edb283e29f035152fcded923dce1ed1fa090e91dc26288e29762e06fac79"
  end

  depends_on "go" => :build

  def install
    system "go", "build", "./cmd/containerd-darwin-snapshotter-grpc"
    system "go", "build", "./cmd/mount_containerd_darwin"
    bin.install "containerd-darwin-snapshotter-grpc"
    bin.install "mount_containerd_darwin"
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test darwin-snapshotter`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "true"
  end
end
