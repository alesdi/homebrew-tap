class Spare10 < Formula
  desc "Circuit breaker that pauses Claude Code before its 5-hour quota runs out"
  homepage "https://github.com/alesdi/spare10"
  url "https://registry.npmjs.org/spare10/-/spare10-0.6.0.tgz"
  sha256 "a27e4a498d5dc77b36246b9b87be84f557568dc5bda30f0e70c1e049515b544b"
  license "MIT"

  # spare10 is a Node program. Bundling a runtime would cost 60-110MB and measured
  # slower than the script it came from, so the formula depends on one instead.
  depends_on "node"

  def install
    libexec.install "dist/spare10.js"
    chmod 0755, libexec/"spare10.js"
    bin.install_symlink libexec/"spare10.js" => "spare10"
  end

  test do
    assert_match "pause Claude Code", shell_output("#{bin}/spare10 --help")
    assert_match "must be a whole number", shell_output("#{bin}/spare10 --reserve 1.5 claude 2>&1", 2)
  end
end
