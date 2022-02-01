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
    url "https://github.com/ukontainer/frankenlibc/releases/download/dev/frankenlibc-amd64-osx.tar.gz"
    sha256 "6be4a27ce684bdea48f582b5fb3afd05cf57b54648561ec24857e25d05fd2154"
  end
  resource "linux-libc" do
    url "https://github.com/ukontainer/frankenlibc/releases/download/dev/frankenlibc-amd64-linux.tar.gz"
    sha256 "1e85444381ac1cc83c06550d33fcbd5a7d6150010476ed497d5e00ad9e974d46"
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
    system "true"
  end
end
