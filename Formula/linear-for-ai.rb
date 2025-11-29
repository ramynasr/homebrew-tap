class LinearForAi < Formula
  desc "CLI tool for AI agents to interact with Linear's GraphQL API"
  homepage "https://github.com/ramynasr/linear-for-ai"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-macos-arm64"
      sha256 "f39a97f24d208436cc13d9021c8da8b21f037f7407bde7c4553217c3fb2bd967"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-macos-x64"
      sha256 "b1024b94a12284586cffc656289b9730aafb79057ea7e97b10940808d181e4d9"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-linux-arm64"
      sha256 "a66ea40f23800026aff797b0f26175cc2c31d96906603c58a32ee70082791e23"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-linux-x64"
      sha256 "22aa2795b94870b371f164046fff5fda21c044ee71530f02d48c0350dfb355cf"
    end
  end

  def install
    bin.install Dir["linear-for-ai*"].first => "linear-for-ai"
  end

  test do
    system "#{bin}/linear-for-ai", "--version"
  end
end
