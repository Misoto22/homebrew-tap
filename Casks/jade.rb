cask "jade" do
  version "0.2.0"
  sha256 "fa8ed8ca6eb649efcc2246351894d039cbea8f8e125b8d4b2d6bd532c34cfe24"

  url "https://github.com/Misoto22/jade/releases/download/v#{version}/Jade-#{version}.dmg"
  name "Jade"
  desc "Break reminder with a resident desktop cat"
  homepage "https://github.com/Misoto22/jade"

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

  uninstall quit: "io.github.misoto22.jade-gatekeeper"

  zap trash: [
    "~/Library/Application Support/Jade",
    "~/Library/Preferences/io.github.misoto22.jade-gatekeeper.plist",
  ]
end
