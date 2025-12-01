class LinearForAi < Formula
  desc "CLI tool for AI agents to interact with Linear's GraphQL API"
  homepage "https://github.com/ramynasr/linear-for-ai"
  version "0.3.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.3.0/linear-for-ai-macos-arm64"
      sha256 "f3b1d7d5fa2efea61117b716f7768bbf66aa3d87105622a7f8a7daaae5ce61ea"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.3.0/linear-for-ai-macos-x64"
      sha256 "afb464e00e5832d137a931d3dec8dc5e4689a50052cfafed9a988b762e153a1f"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.3.0/linear-for-ai-linux-arm64"
      sha256 "f2c17d3289747a182570381538c52e25e6b6a465ead3002523df8fcda0f0b7e1"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.3.0/linear-for-ai-linux-x64"
      sha256 "5539351f1d144a1f0c762901e1241cf6b47dabe4544307bfe947fa3d271491ee"
    end
  end

  def install
    bin.install Dir["linear-for-ai*"].first => "linear-for-ai"
  end

  test do
    system "#{bin}/linear-for-ai", "--version"
  end
end
