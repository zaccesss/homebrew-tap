# Homebrew formula for Footprints 0.2.0, for Formula/footprints.rb in the zaccesss/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v0.2.0 release; packaging/fill-checksums.sh fills them in. The next release changes the version
# in the four URLs and the four sums.
class Footprints < Formula
  desc "See and undo what AI agents do on your machine"
  homepage "https://github.com/zaccesss/footprints"
  version "0.2.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/zaccesss/footprints/releases/download/v0.2.0/footprints-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "4e10a21ad98e12a34d1cac18ebe6f72ca0a6a822ebd9b5b369c12ac9289cf8d2"
    end
    on_intel do
      url "https://github.com/zaccesss/footprints/releases/download/v0.2.0/footprints-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "a20896b2de7eacc520837af6bb591eba17a772ff20c3e57621dae0f7ec51af09"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zaccesss/footprints/releases/download/v0.2.0/footprints-v0.2.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "8e2be24b77693d73f55414beb7d3b79cd4ef27a9c4fee141b419fd4a86afddbf"
    end
    on_intel do
      url "https://github.com/zaccesss/footprints/releases/download/v0.2.0/footprints-v0.2.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "7709776ece5990d2c7ecb8a5b89eb726ba397e2a5a8aed9f703a3864640f0b3d"
    end
  end

  def install
    bin.install "footprints"
    doc.install "README.md", "CHANGELOG.md", "ACCESSIBILITY.md", "NOTICE"
  end

  test do
    assert_match "footprints #{version}", shell_output("#{bin}/footprints --version")
    ENV["FOOTPRINTS_HOME"] = testpath/"ledger"
    (testpath/"work").mkpath
    system bin/"footprints", "run", "--dir", testpath/"work", "--", "sh", "-c", "echo hi > made.txt"
    assert_match "file_create", shell_output("#{bin}/footprints log")
  end
end
