# CLAUDE.md

Project rules for AI agents working on the homebrew-tap repository.

## Project Overview

Official Homebrew tap for Ramy Nasr's CLI tools and applications. A tap is a third-party Homebrew repository that provides formulae for installing software.

**Repository:** https://github.com/ramynasr/homebrew-tap (public)

## Core Principles

**Tap Structure:**
- Single tap serves multiple applications
- Each application has its own formula file in `Formula/`
- README lists all available tools with links and descriptions
- All tools support macOS (Intel + ARM) and Linux (x64 + ARM64)

**Formula Management:**
- Formulae are Ruby files following Homebrew DSL conventions
- Each formula downloads pre-built binaries from GitHub releases
- SHA256 checksums verify binary integrity
- Automated updates via source project's GitHub Actions

**Version Control:**
- One commit per formula update
- Commit message format: "Update <tool-name> to v<version>"
- Never commit test formulae or WIP changes
- Git history shows clear version progression

## Repository Structure

```
homebrew-tap/
├── Formula/
│   ├── linear-for-ai.rb      # Formula for linear-for-ai CLI
│   └── <other-tool>.rb        # Additional tools as added
├── README.md                  # User-facing documentation
├── CLAUDE.md                  # This file (project rules)
└── .git/                      # Git repository
```

## Formula Template

When adding a new tool, use this structure:

```ruby
class ToolName < Formula
  desc "Short description of the tool"
  homepage "https://github.com/ramynasr/tool-name"
  version "0.1.0"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/tool-name/releases/download/v#{version}/tool-name-macos-arm64"
      sha256 "CHECKSUM_HERE"
    else
      url "https://github.com/ramynasr/tool-name/releases/download/v#{version}/tool-name-macos-x64"
      sha256 "CHECKSUM_HERE"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/ramynasr/tool-name/releases/download/v#{version}/tool-name-linux-arm64"
      sha256 "CHECKSUM_HERE"
    else
      url "https://github.com/ramynasr/tool-name/releases/download/v#{version}/tool-name-linux-x64"
      sha256 "CHECKSUM_HERE"
    end
  end

  def install
    bin.install Dir["tool-name*"].first => "tool-name"
  end

  test do
    system "#{bin}/tool-name", "--version"
  end
end
```

## Adding a New Tool

**Prerequisites:**
- Tool must have GitHub releases with binaries for all 4 platforms
- Binaries must be named consistently: `<tool>-<platform>-<arch>`
- Repository must be public (Homebrew can't download from private repos)

**Steps:**

1. **Create the formula file:**
   ```bash
   cd Formula/
   touch new-tool.rb
   ```

2. **Download binaries and calculate checksums:**
   ```bash
   # For each platform
   curl -L https://github.com/ramynasr/tool/releases/download/v0.1.0/tool-platform -o tool-platform
   shasum -a 256 tool-platform
   ```

3. **Fill in the formula** using the template above

4. **Test locally:**
   ```bash
   brew install --build-from-source ./Formula/new-tool.rb
   brew test new-tool
   brew uninstall new-tool
   ```

5. **Update README** with new tool in "Available Tools" section

6. **Commit and push:**
   ```bash
   git add Formula/new-tool.rb README.md
   git commit -m "Add new-tool formula v0.1.0"
   git push origin main
   ```

7. **Test installation:**
   ```bash
   brew update
   brew install ramynasr/tap/new-tool
   ```

## Updating a Formula

Formulae are typically updated automatically by the source project's CI/CD, but manual updates:

1. **Download new binaries and calculate checksums:**
   ```bash
   for platform in macos-x64 macos-arm64 linux-x64 linux-arm64; do
     curl -L https://github.com/ramynasr/tool/releases/download/v0.2.0/tool-$platform -o /tmp/tool-$platform
     shasum -a 256 /tmp/tool-$platform
   done
   ```

2. **Update the formula:**
   - Change `version "0.2.0"`
   - Update all 4 `sha256` values

3. **Commit and push:**
   ```bash
   git add Formula/tool.rb
   git commit -m "Update tool to v0.2.0"
   git push origin main
   ```

## Automation Integration

Most tools in this tap have automated updates via their source repository's GitHub Actions:

**Typical workflow in source repo:**
1. Tag pushed (e.g., `v0.2.0`)
2. GitHub Actions builds binaries for all platforms
3. GitHub Actions creates release with binaries
4. GitHub Actions calculates checksums
5. GitHub Actions updates formula in this tap
6. GitHub Actions commits and pushes to this repo

**Requirements for automation:**
- Source repo needs `HOMEBREW_TAP_TOKEN` secret
- Token must have write access to this repository
- Update script must be idempotent

**Example update script structure:**
```bash
# Download binaries
curl -L <url> -o binary
checksum=$(shasum -a 256 binary | awk '{print $1}')

# Update formula
sed -i "s/version \".*\"/version \"$VERSION\"/" Formula/tool.rb
sed -i "s/sha256 \".*\"/sha256 \"$checksum\"/" Formula/tool.rb

# Commit and push
git config user.name "github-actions[bot]"
git config user.email "github-actions[bot]@users.noreply.github.com"
git add Formula/tool.rb
git commit -m "Update tool to v$VERSION"
git push
```

## Testing Formulae

**Local testing:**
```bash
# Audit formula for issues
brew audit --strict Formula/tool.rb

# Install from local formula
brew install --build-from-source ./Formula/tool.rb

# Test the formula's test block
brew test tool

# Check for common issues
brew doctor
```

**Testing after push:**
```bash
# Update tap
brew update

# Install from tap
brew install ramynasr/tap/tool

# Verify it works
tool --version
tool --help

# Cleanup
brew uninstall tool
```

## Common Issues

**Checksum mismatch:**
- Caused by downloading binaries before repo is public
- Or downloading wrong version
- Solution: Recalculate checksums from correct source

**Binary not executable:**
- Formula must use `bin.install` not just `install`
- Ensure binary has execute permissions in release

**Wrong binary name:**
- Formula looks for binaries matching pattern
- Ensure release asset names match expected pattern
- Use `Dir["tool-name*"].first` to find binary

**Formula not found after tap:**
- Run `brew update` to refresh tap
- Check formula file has correct class name (matches filename)
- Verify tap was added: `brew tap`

## Security

**Binary Verification:**
- Always include SHA256 checksums
- Never use placeholder checksums (all zeros)
- Checksums must match actual release binaries

**Access Control:**
- Only automation tokens should have write access
- Tokens should be limited to this repository only
- Rotate tokens if compromised

**Git Hygiene:**
- Never force push to main branch
- All commits should be traceable
- Avoid rebasing published history

## Homebrew Guidelines

Follow Homebrew's style guide and best practices:

**Naming:**
- Formula class name: `CamelCase` matching `snake-case` filename
- Binary name in `bin.install` should match CLI command
- Description: Short, descriptive, starts with capital, no period

**URLs:**
- Use GitHub releases for binaries
- Include version in URL when possible
- Use `#{version}` variable in URLs

**Testing:**
- Test block should verify binary works
- Usually just `--version` or `--help` flag
- Keep tests simple and fast

**Documentation:**
- `desc` should be one line, clear, descriptive
- `homepage` should be main project URL
- Include `license` field

## Development Workflow

**For formulae updates:**
1. Create branch if making experimental changes
2. Test locally before pushing
3. Push to main when ready (formulae are usually auto-updated)
4. Verify users can install after push

**For README updates:**
1. Edit README.md
2. Commit with descriptive message
3. Push directly to main

**For structure changes:**
1. Discuss design first
2. Test thoroughly
3. Document in this file
4. Update README if user-facing

## Resources

- **Homebrew Formula Cookbook:** https://docs.brew.sh/Formula-Cookbook
- **Homebrew DSL Reference:** https://rubydoc.brew.sh/Formula
- **Tap Documentation:** https://docs.brew.sh/How-to-Create-and-Maintain-a-Tap
- **Source Projects:** Listed in README.md

## Maintenance

**Regular tasks:**
- Keep formulae updated (usually automated)
- Test installations after updates
- Monitor issues in source repositories
- Update README when adding/removing tools

**No maintenance needed for:**
- Homebrew itself (users update independently)
- Binary builds (handled by source repos)
- Checksum calculations (automated)
