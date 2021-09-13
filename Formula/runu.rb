HOMEBREW_RUNU_REVISION="feature-v2-shim".freeze
HOMEBREW_RUNU_VERSION="beta1".freeze

class Runu < Formula
  desc "OCI runtime for frankenlibc unikernel"
  homepage "https://github.com/ukontainer/runu"
  url "https://github.com/ukontainer/runu.git", branch: HOMEBREW_RUNU_REVISION
  version HOMEBREW_RUNU_VERSION
  # sha256 ""
  license ""

  depends_on "go" => :build

  resource "osx-lkick" do
    url "https://github.com/ukontainer/frankenlibc/releases/download/dev/frankenlibc-amd64-osx.tar.gz", :using => :curl
    sha256 "3dc8d8bdfde00347a0a169aae5f27aa6690f5ee3f363b3ffc00395fcdb000c47"
  end
  resource "linux-libc" do
    url "https://github.com/ukontainer/frankenlibc/releases/download/dev/frankenlibc-amd64-linux.tar.gz", :using => :curl
    sha256 "96d489b1c927bcde88296b1d6ecdaac4a9521a192d4b38f708dd08bb0dcb6c04"
  end

  def install
    system "go", "build"
    system "go", "build", "-o", "./containerd-shim-runu-v1", "./cmd/containerd-shim-runu-v1"
    bin.install "./runu"
    bin.install "./containerd-shim-runu-v1"
    (prefix/"lib/runu").mkpath
    resource("linux-libc").stage do
      (prefix/"lib/runu").install "./rump/lib/libc.so"
    end
    resource("osx-lkick").stage do
      (prefix/"lib/runu").install "./rump/bin/lkick"
    end
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
