cask "jade" do
  version "0.8.1"
  sha256 "0dafccad3f0b50c22daf37452c572c95e30c9780c323b82e53cfe1673ed4532f"

  url "https://github.com/jade-pet/jade-releases/releases/download/v#{version}/Jade-#{version}.dmg"
  name "Jade"
  desc "Desktop cat and break reminder, companion to the Jade mood diary"
  homepage "https://jadethecat.com"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "Jade.app"

  # Releases are signed ad hoc until the project has a Developer ID, and macOS
  # refuses to open a quarantined app it cannot verify. Remove this once
  # releases are notarised.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Jade.app"]
  end

  uninstall quit: [
    "io.github.jade-pet.jade",
    "io.github.misoto22.jade-gatekeeper",
  ]

  zap trash: [
    "~/Library/Application Support/Jade",
    "~/Library/Preferences/io.github.jade-pet.jade.plist",
    "~/Library/Preferences/io.github.misoto22.jade-gatekeeper.plist",
  ]
end
