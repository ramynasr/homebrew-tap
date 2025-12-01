class LinearForAi < Formula
  desc "CLI tool for AI agents to interact with Linear's GraphQL API"
  homepage "https://github.com/ramynasr/linear-for-ai"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-macos-arm64"
      sha256 "3256741649dbc32d8141086c17f52956cfa6923dd8f3d0bf4fb7c9da3a7893fc"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-macos-x64"
      sha256 "48a057304d7961b5b5e01230c6e838ab9fbfcdcc34c5c03ad8651de78ee319a7"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-linux-arm64"
      sha256 "f64963e5e380792a1c82ae4ce044fb6d9eb1d17e832609895597055725503e5d"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-linux-x64"
      sha256 "28edc4c75bd79856f18299af1dbb8079280a9889c19538252e9f07b917e9971a"
    end
  end

  def install
    bin.install Dir["linear-for-ai*"].first => "linear-for-ai"
  end

  test do
    system "#{bin}/linear-for-ai", "--version"
  end
end
