# Homebrew formula for Footprints 0.4.0, for Formula/footprints.rb in the zaccesss/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v0.4.0 release; packaging/fill-checksums.sh fills them in. The release workflow moves a copy to
# each new tag's version before filling it, so the version here can lag behind the latest release.
class Footprints < Formula
  desc "See and undo what AI agents do on your machine"
  homepage "https://github.com/zaccesss/footprints"
  version "0.4.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/zaccesss/footprints/releases/download/v0.4.0/footprints-v0.4.0-aarch64-apple-darwin.tar.gz"
      sha256 "d2a539ef0595e51c63ec2671d99c162b14589962a12ed7314322c06f66e87f1d"
    end
    on_intel do
      url "https://github.com/zaccesss/footprints/releases/download/v0.4.0/footprints-v0.4.0-x86_64-apple-darwin.tar.gz"
      sha256 "9af4ad193dff7dba95ed894bcd7c8430eb898ba123a3e6c6c1fe9ecc032e0f7d"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zaccesss/footprints/releases/download/v0.4.0/footprints-v0.4.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "54c34eff558d0407be6422a1eff6f2fa58ebfec13e641ee756f0c5de2cd51cd5"
    end
    on_intel do
      url "https://github.com/zaccesss/footprints/releases/download/v0.4.0/footprints-v0.4.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "ee4aadf359cc659818daf817d3d2528b8d70f004accbe3a29b48fbd03419ea3a"
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
