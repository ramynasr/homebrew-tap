class LinearForAi < Formula
  desc "CLI tool for AI agents to interact with Linear's GraphQL API"
  homepage "https://github.com/ramynasr/linear-for-ai"
  version "0.4.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.4.0/linear-for-ai-macos-arm64"
      sha256 "ea45b117f774e1f4c7ede0d5446585370ed6de21eaf3f4de5ffc47ff43b5efab"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.4.0/linear-for-ai-macos-x64"
      sha256 "f6d2c34a62a28dec5ccf030517fdb6ad0ea685ee785c750dbfc6ecdf50d9cf91"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.4.0/linear-for-ai-linux-arm64"
      sha256 "b2515a9437bc935c33ecd5261ec5f522a4eb24da55433ce93829c4d16b9ff42a"
    else
      url "https://github.com/ramynasr/linear-for-ai/releases/download/v0.4.0/linear-for-ai-linux-x64"
      sha256 "48eae1ed70517d40852eee9f6edbaaec3290c670bb1c758a2a1ad690b09936cf"
    end
  end

  def install
    bin.install Dir["linear-for-ai*"].first => "linear-for-ai"
  end

  test do
    system "#{bin}/linear-for-ai", "--version"
  end
end
