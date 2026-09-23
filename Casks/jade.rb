cask "jade" do
  version "0.5.0"
  sha256 "0e69fdcab657074b85e82aa6879e65cebf242e9d33c045b3f96887eb744f629b"

  url "https://github.com/jade-pet/jade-macos/releases/download/v#{version}/Jade-#{version}.dmg"
  name "Jade"
  desc "Desktop cat and break reminder, companion to the Jade mood diary"
  homepage "https://github.com/jade-pet/jade-macos"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :tahoe

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
