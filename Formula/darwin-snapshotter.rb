HOMEBREW_REVISION="01a94b59181f5ad90657f9ae80dfce0da4581be7".freeze
HOMEBREW_VERSION="v1.0".freeze

class DarwinSnapshotter < Formula
  desc "Snapshotter plugin for conatined/macOS"
  homepage "https://github.com/ukontainer/darwin-snapshotter"
  url "https://github.com/ukontainer/darwin-snapshotter.git", revision: HOMEBREW_REVISION
  version HOMEBREW_VERSION
  # sha256 ""
  license ""

  bottle do
    root_url "https://github.com/ukontainer/homebrew-lkl/releases/download/darwin-snapshotter-v1.0"
    rebuild 1
    sha256 cellar: :any_skip_relocation, big_sur: "662a0507bc40927b14e8d02209d3425bd0f67e8a14e4d9df6b243fa8c4c2430b"
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
