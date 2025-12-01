class LinearForAi < Formula
  desc "CLI tool for AI agents to interact with Linear's GraphQL API"
  homepage "https://github.com/ramynasr/linear-for-ai"
  version "0.2.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-macos-arm64"
      sha256 "949fc7e300195484c7549f214fb6481d1b02690dfb80bf2802b8493c87e08f30"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-macos-x64"
      sha256 "6ee2e76494ac1a2eec1d584befc29eb06422c07a5ffa6da4116879bd97056b03"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-linux-arm64"
      sha256 "24b8f34bf602060a37b1daea00f4ad0e71b87a50eead3ec9ec6c1f2748badecf"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.2.0/linear-for-ai-linux-x64"
      sha256 "dba8ae3790e71ac266fee308e22f5317b4993f763ade4b8d425804339af5a811"
    end
  end

  def install
    bin.install Dir["linear-for-ai*"].first => "linear-for-ai"
  end

  test do
    system "#{bin}/linear-for-ai", "--version"
  end
end
