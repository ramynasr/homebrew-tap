class LinearForAi < Formula
  desc "CLI tool for AI agents to interact with Linear's GraphQL API"
  homepage "https://github.com/ramynasr/linear-for-ai"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-macos-arm64"
      sha256 "c4e0fefca903ab00182a40a4b5f87c87bfbfd58cd7b96b3e2a46d544b2eb2dc2"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-macos-x64"
      sha256 "f2fe4825f3fa7a8594118008030a8a764d0ff1ac85a849050e6098c62f10df00"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-linux-arm64"
      sha256 "ad6ae09b398d16e99714b363b24f7b6f54f4d8bab57901333c2cc8c45791cf93"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.1.0/linear-for-ai-linux-x64"
      sha256 "4684547ef5a82d1ffd9302b3c8de8b4b15ab552c7e4c67c7ea2461623b032db7"
    end
  end

  def install
    bin.install Dir["linear-for-ai*"].first => "linear-for-ai"
  end

  test do
    system "#{bin}/linear-for-ai", "--version"
  end
end
