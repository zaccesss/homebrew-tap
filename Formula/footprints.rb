# Homebrew formula for Footprints 0.3.0, for Formula/footprints.rb in the zaccesss/homebrew-tap
# repository. Each SHA256_ placeholder is the sum from the matching .sha256 file attached to the
# v0.3.0 release; packaging/fill-checksums.sh fills them in. The release workflow moves a copy to
# each new tag's version before filling it, so the version here can lag behind the latest release.
class Footprints < Formula
  desc "See and undo what AI agents do on your machine"
  homepage "https://github.com/zaccesss/footprints"
  version "0.3.0"
  license "Apache-2.0"

  on_macos do
    on_arm do
      url "https://github.com/zaccesss/footprints/releases/download/v0.3.0/footprints-v0.3.0-aarch64-apple-darwin.tar.gz"
      sha256 "e190d7e0d0bf6dddefa20f53e33db9af32fe3d89b3e64dcb14357aeb8628d2f0"
    end
    on_intel do
      url "https://github.com/zaccesss/footprints/releases/download/v0.3.0/footprints-v0.3.0-x86_64-apple-darwin.tar.gz"
      sha256 "ea730097a70416b61808734f9161be89ccc9451c0a2f099649631614a92aa9c6"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/zaccesss/footprints/releases/download/v0.3.0/footprints-v0.3.0-aarch64-unknown-linux-musl.tar.gz"
      sha256 "0d4228af5d149c83aca404ae32fd38725cbb59d2371b394c0556902b3b5eb313"
    end
    on_intel do
      url "https://github.com/zaccesss/footprints/releases/download/v0.3.0/footprints-v0.3.0-x86_64-unknown-linux-musl.tar.gz"
      sha256 "d95c05b0df01384bbed71a5e0cd956947514f05bb1f8a354b2f662166fcefeac"
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
