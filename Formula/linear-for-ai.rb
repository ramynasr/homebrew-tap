class LinearForAi < Formula
  desc "CLI tool for AI agents to interact with Linear's GraphQL API"
  homepage "https://github.com/ramynasr/linear-for-ai"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-macos-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-macos-x64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-linux-arm64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-linux-x64"
      sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
    end
  end

  def install
    bin.install Dir["linear-for-ai*"].first => "linear-for-ai"
  end

  test do
    system "#{bin}/linear-for-ai", "--version"
  end
end
