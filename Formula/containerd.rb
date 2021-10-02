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
    url "https://github.com/ukontainer/containerd/commit/85050fad37c680a53dc928e0cf65de323e60599c.patch?full_index=1"
    sha256 "07a937662b5bbaa595298b506a1739d32e7d778a05408a16945142f2f6513518"
  end
  # darwin snapshotter
  patch do
    url "https://github.com/ukontainer/containerd/commit/1d64f827979b8916b193940a11955d12d12b870f.patch?full_index=1"
    sha256 "b41406b3febaab39a7b1998f34f7f92692f0d27f585a100121bb673023008f2b"
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
