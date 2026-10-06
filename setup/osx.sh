#!/usr/bin/env bash
set -x

# based on http://mths.be/osx
# also adopts portions of cowboy/dotfiles/init/10_osx.sh
# Run as your login user, not `sudo ./osx.sh` (sudo is used where needed).

# exit if not OS X
[[ $(uname) == 'Darwin' ]] || exit 1

# Install Command Line Tools with `xcode-select --install` before running this
# script (see readme.md). `/` is not a valid developer directory.

macos_major=$(sw_vers -productVersion | cut -d . -f 1)

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application id "com.apple.systempreferences" to quit'

# Ask for the administrator password upfront
sudo -v || exit 1

# Keep-alive: update existing `sudo` time stamp until `.osx` has finished
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

hash defaults
hash sudo

###############################################################################
# General UI/UX                                                               #
###############################################################################

# a good way to find new settings is to run `defaults read` and look through the
# full list of system and app settings

# use dark mode
osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to true'

# Set highlight color to green
defaults write -g AppleHighlightColor -string '0.764700 0.976500 0.568600'

# Set sidebar icon size to medium
defaults write NSGlobalDomain NSTableViewDefaultSizeMode -int 2

# Adjust toolbar title rollover delay
defaults write NSGlobalDomain NSToolbarTitleViewRolloverDelay -float 0

# Increase window resize speed for Cocoa applications
defaults write -g NSWindowResizeTime -float 0.001

# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Save to disk (not to iCloud) by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# Disable the “Are you sure you want to open this application?” dialog
defaults write com.apple.LaunchServices LSQuarantine -bool false

# Remove duplicates in the “Open With” menu (also see `lscleanup` alias)
/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user

# Display ASCII control characters using caret notation in standard text views
# Try e.g. `cd /tmp; unidecode "\x{0000}" > cc.txt; open -e cc.txt`
defaults write -g NSTextShowsControlCharacters -bool true

# Disable automatic termination of inactive apps
defaults write NSGlobalDomain NSDisableAutomaticTermination -bool true

# Set Help Viewer windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# Reveal IP address, hostname, OS version, etc. when clicking the clock
# in the login window
sudo defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Show WiFi, Battery, Time Machine, & Clock in menu bar
# removes Bluetooth & Sound
if (( macos_major < 11 )); then
defaults write com.apple.systemuiserver menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/Battery.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu" \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu"

# Date/time in menu bar like: Sun Aug 17 22:53
defaults write com.apple.menuextra.clock DateFormat -string "EEE MMM d  HH:mm"
else
    # Big Sur replaced the old menu extras with Control Center. Configure
    # visibility in System Settings > Menu Bar (Control Center on macOS 15).
    defaults write com.apple.menuextra.clock Show24Hour -bool true
    defaults write com.apple.menuextra.clock ShowAMPM -bool false
    defaults write com.apple.menuextra.clock ShowDayOfWeek -bool true
    defaults write com.apple.menuextra.clock ShowDate -int 1
fi
defaults write com.apple.menuextra.clock FlashDateSeparators -bool false
defaults write com.apple.menuextra.clock IsAnalog -bool false

# Disable the crash reporter
defaults write com.apple.CrashReporter DialogType -string "none"

# Disable smart quotes, automatic capitalization, smart dashes
# & automatic period substitution as they’re all annoying when typing code
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false
defaults write -g NSAutomaticCapitalizationEnabled -bool false
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false
defaults write -g NSAutomaticPeriodSubstitutionEnabled -bool false

# Disable auto-correct
# defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false

# Set font smoothing strength. This does not enable subpixel rendering, which
# was removed in Mojave, and 1 means light smoothing rather than disabled.
defaults write -g AppleFontSmoothing -int 1

###############################################################################
# Trackpad, mouse, keyboard, Bluetooth accessories, and input                 #
###############################################################################

# Trackpad: enable tap to click for this user. Login-window preferences belong
# to a different user; these commands do not configure the login screen.
defaults write com.apple.AppleMultitouchTrackpad Clicking -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -bool true
defaults -currentHost write -g com.apple.mouse.tapBehavior -int 1
defaults write -g com.apple.mouse.tapBehavior -int 1

# set click pressure sensitivity to "light"
defaults write com.apple.AppleMultitouchTrackpad FirstClickThreshold -int 0
defaults write com.apple.AppleMultitouchTrackpad SecondClickThreshold -int 0

# Trackpad: map bottom right corner to right-click
defaults write com.apple.AppleMultitouchTrackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.AppleMultitouchTrackpad TrackpadRightClick -bool true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadCornerSecondaryClick -int 2
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadRightClick -bool true
defaults -currentHost write -g com.apple.trackpad.trackpadCornerClickBehavior -int 1
defaults -currentHost write -g com.apple.trackpad.enableSecondaryClick -bool true

# Enable full keyboard access for all controls
# (e.g. enable Tab in modal dialogs)
# This is keyboard navigation, not Accessibility's separate Full Keyboard Access.
defaults write -g AppleKeyboardUIMode -int 3

# Use scroll gesture with the Ctrl (^) modifier key to zoom
# Modern macOS may deny writes to this protected preference domain. In that
# case configure Accessibility > Zoom in System Settings; do not disable SIP.
defaults write com.apple.universalaccess closeViewScrollWheelToggle -bool true
defaults write com.apple.universalaccess HIDScrollZoomModifierMask -int 262144
# Follow the keyboard focus while zoomed in
defaults write com.apple.universalaccess closeViewZoomFollowsFocus -bool true

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Set a blazingly fast keyboard repeat rate
defaults write -g KeyRepeat -int 1
defaults write -g InitialKeyRepeat -int 10

# Set language and text formats
defaults write -g AppleLanguages -array "en"
defaults write -g AppleLocale -string "en_US@currency=USD"

# add a text replacement for mac cmd symbol
defaults write -g NSUserDictionaryReplacementItems -array-add '{on = 1;replace = "[cmd]";with = "\\U2318";}'

# Set the timezone; see `systemsetup -listtimezones` for other values
sudo systemsetup -settimezone "America/Los_Angeles" > /dev/null

###############################################################################
# Energy saving                                                               #
###############################################################################

# Only set hardware-dependent options advertised by this Mac.
power_capabilities=$(pmset -g cap)
if [[ $power_capabilities =~ [[:space:]]lidwake([[:space:]]|$) ]]; then
    sudo pmset -a lidwake 1
fi
if [[ $power_capabilities =~ [[:space:]]autorestart([[:space:]]|$) ]]; then
    sudo pmset -a autorestart 1
fi

# Sleep the display after 15 minutes
sudo pmset -a displaysleep 15

# Disable machine sleep while charging
sudo pmset -c sleep 0

# Set machine sleep to 5 minutes on battery
if pmset -g batt | /usr/bin/grep -q 'InternalBattery'; then
    sudo pmset -b sleep 5
fi

###############################################################################
# Screen                                                                      #
###############################################################################

# Turn off "displays have separate spaces" which forces app switcher to stay on laptop display & not external monitors
defaults write com.apple.spaces spans-displays -bool true

# Require password immediately after sleep or screen saver begins
# Legacy preferences: verify System Settings > Lock Screen on modern macOS;
# successful defaults writes alone do not prove the password policy changed.
defaults write com.apple.screensaver askForPassword -int 1
defaults write com.apple.screensaver askForPasswordDelay -int 0

# Save screenshots to downloads folder
defaults write com.apple.screencapture location -string "$HOME/Downloads"

# Save screenshots in PNG format (other options: BMP, GIF, JPG, PDF, TIFF)
defaults write com.apple.screencapture type -string "png"

# Disable shadow in screenshots
defaults write com.apple.screencapture disable-shadow -bool true

###############################################################################
# Finder                                                                      #
###############################################################################

# Finder: allow quitting via ⌘ + Q; doing so will also hide desktop icons
defaults write com.apple.finder QuitMenuItem -bool true

# Finder: disable window animations and Get Info animations
defaults write com.apple.finder DisableAllAnimations -bool true

# Set Downloads as the default location for new Finder windows
defaults write com.apple.finder NewWindowTarget -string "PfLo"
defaults write com.apple.finder NewWindowTargetPath -string "file://${HOME}/Downloads/"

# Show icons for hard drives, servers, and removable media on the desktop
defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true
defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
defaults write com.apple.finder ShowRemovableMediaOnDesktop -bool true

# Finder: show hidden files by default
defaults write com.apple.finder AppleShowAllFiles -bool true

# Finder: show all filename extensions
defaults write -g AppleShowAllExtensions -bool true

# Keep folders on top when sorting by name
defaults write com.apple.finder _FXSortFoldersFirst -bool true

# Finder: show status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Finder: show path bar
defaults write com.apple.finder ShowPathbar -bool true

# Display full POSIX path as Finder window title
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true

# When performing a search, search the current folder by default
# defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"

# Delete files left in trash for 30 days
defaults write com.apple.finder FXRemoveOldTrashItems -bool true

# Disable the warning when changing a file extension
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false

# Enable spring loading for directories
defaults write -g com.apple.springing.enabled -bool true

# Remove the spring loading delay for directories
defaults write -g com.apple.springing.delay -float 0

# Avoid creating .DS_Store files on network or USB volumes
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

# Automatically open a new Finder window when a volume is mounted
defaults write com.apple.frameworks.diskimages auto-open-ro-root -bool true
defaults write com.apple.frameworks.diskimages auto-open-rw-root -bool true
defaults write com.apple.finder OpenWindowForNewRemovableDisk -bool true

# Edit an exported plist rather than the live file behind cfprefsd's back.
# On a fresh account these dictionaries/keys may not exist yet.
configure_finder_icon_views() (
    set -e
    # Keep the temp path in subshell scope so the EXIT trap can read it even
    # after Bash unwinds the function's local variables on an error.
    local view key value type
    finder_plist=$(mktemp "${TMPDIR:-/tmp}/osx-finder.XXXXXX") || return 1
    trap 'rm -f "$finder_plist"' EXIT
    defaults export com.apple.finder "$finder_plist"
    for view in DesktopViewSettings FK_StandardViewSettings StandardViewSettings; do
        if ! /usr/libexec/PlistBuddy -c "Print :$view" "$finder_plist" >/dev/null 2>&1; then
            /usr/libexec/PlistBuddy -c "Add :$view dict" "$finder_plist"
        fi
        if ! /usr/libexec/PlistBuddy -c "Print :$view:IconViewSettings" "$finder_plist" >/dev/null 2>&1; then
            /usr/libexec/PlistBuddy -c "Add :$view:IconViewSettings dict" "$finder_plist"
        fi
        # Show item info, snap to grid, use 100px spacing and 80px icons.
        for key in showItemInfo arrangeBy gridSpacing iconSize labelOnBottom; do
            case $key in
                showItemInfo) type=bool; value=true ;;
                arrangeBy) type=string; value=grid ;;
                gridSpacing) type=real; value=100 ;;
                iconSize) type=real; value=80 ;;
                labelOnBottom)
                    [[ $view == DesktopViewSettings ]] || continue
                    type=bool; value=false ;;
            esac
            if /usr/libexec/PlistBuddy -c "Print :$view:IconViewSettings:$key" "$finder_plist" >/dev/null 2>&1; then
                /usr/libexec/PlistBuddy -c "Set :$view:IconViewSettings:$key $value" "$finder_plist"
            else
                /usr/libexec/PlistBuddy -c "Add :$view:IconViewSettings:$key $type $value" "$finder_plist"
            fi
        done
    done
    defaults import com.apple.finder "$finder_plist"
)
configure_finder_icon_views

# Create Code and add it plus existing Google Drive folders to the sidebar.
# Finder UI scripting needs Accessibility access for the terminal running this
# script (System Settings > Privacy & Security > Accessibility).
configure_finder_sidebar() {
    local script_dir folder
    local sidebar_folders=("$HOME/Code")
    mkdir -p "$HOME/Code" || return 1
    script_dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd) || return 1
    for folder in "$HOME"/*Google*Drive* "$HOME/Library/CloudStorage"/*Google*Drive*; do
        [[ -d $folder ]] || continue
        sidebar_folders+=("$folder")
    done
    osascript "$script_dir/finder-sidebar.applescript" "${sidebar_folders[@]}"
}
if ! configure_finder_sidebar; then
    echo "Finder sidebar setup failed; check the error above and your terminal's Accessibility/Automation permissions." >&2
fi

# Use column view in all Finder windows by default
# Four-letter codes for the other view modes: `Nlsv`, `icnv`, `clmv`, `glyv` (Gallery; `Flwv` was Cover Flow)
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"

# Disable the warning before emptying the Trash
defaults write com.apple.finder WarnOnEmptyTrash -bool false

# Show the ~/Library & /Volumes folders
chflags nohidden ~/Library
if xattr -p com.apple.FinderInfo ~/Library >/dev/null 2>&1; then
    xattr -d com.apple.FinderInfo ~/Library
fi
sudo chflags nohidden /Volumes

# Expand the following File Info panes:
# “General”, “Open with”, and “Sharing & Permissions”
defaults write com.apple.finder FXInfoPanesExpanded -dict \
	General -bool true \
	OpenWith -bool true \
	Privileges -bool true

###############################################################################
# Dock, Dashboard, and hot corners                                            #
###############################################################################

# Enable highlight hover effect for the grid view of a stack (Dock)
defaults write com.apple.dock mouse-over-hilite-stack -bool true

# big (84px) icons in the Dock
defaults write com.apple.dock tilesize -int 84

# Enable spring loading for all Dock items
defaults write com.apple.dock enable-spring-load-actions-on-all-items -bool true

# Show indicator lights for open applications in the Dock
defaults write com.apple.dock show-process-indicators -bool true

# Don’t animate opening applications from the Dock
defaults write com.apple.dock launchanim -bool false

# Speed up Mission Control animations
defaults write com.apple.dock expose-animation-duration -float 0.1

# Don’t group windows by application in Mission Control
# (i.e. use the old Exposé behavior instead)
defaults write com.apple.dock expose-group-by-app -bool false

# Remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0
# Remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# Automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# Make Dock icons of hidden applications translucent
defaults write com.apple.dock showhidden -bool true

# Disable the Launchpad gesture (pinch with thumb and three fingers)
if (( macos_major < 26 )); then
defaults write com.apple.dock showLaunchpadGestureEnabled -int 0
fi
# Do not delete Dock databases to reset Launchpad; newer macOS uses Apps.

# Wipe all (default) app icons from the Dock
# This is only really useful when setting up a new Mac, or if you don’t use
# the Dock to launch apps.
defaults write com.apple.dock persistent-apps -array

# Add a spacer to the left side of the Dock (where the applications are)
defaults write com.apple.dock persistent-apps -array-add '{tile-data={}; tile-type="spacer-tile";}'
# Add a spacer to the right side of the Dock (where the Trash is)
defaults write com.apple.dock persistent-others -array-add '{tile-data={}; tile-type="spacer-tile";}'

# Hot corners: set Top Left to Mission Control & disable all others
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard (removed in Catalina)
# 10: Put display to sleep
# 11: Launchpad (legacy)
# 12: Notification Center
# 13: Lock Screen
defaults write com.apple.dock wvous-tl-corner -int 2
defaults write com.apple.dock wvous-tl-modifier -int 0
defaults write com.apple.dock wvous-tr-corner -int 0
defaults write com.apple.dock wvous-tr-modifier -int 0
defaults write com.apple.dock wvous-br-corner -int 0
defaults write com.apple.dock wvous-br-modifier -int 0
defaults write com.apple.dock wvous-bl-corner -int 0
defaults write com.apple.dock wvous-bl-modifier -int 0

###############################################################################
# WebKit                                                                      #
###############################################################################

# Privacy: don’t send search queries to Apple
defaults write com.apple.Safari UniversalSearchEnabled -bool false
defaults write com.apple.Safari SuppressSearchSuggestions -bool true

# Show the full URL in the address bar (note: this still hides the scheme)
defaults write com.apple.Safari ShowFullURLInSmartSearchField -bool true

# Hide Safari’s bookmarks bar by default
defaults write com.apple.Safari ShowFavoritesBar -bool false

# Enable Safari’s debug menu
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true

# Make Safari’s search banners default to Contains instead of Starts With
defaults write com.apple.Safari FindOnPageMatchesWordStartsOnly -bool false

# Enable the Develop menu and the Web Inspector in Safari
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled -bool true

# Add a context menu item for showing the Web Inspector in web views
defaults write -g WebKitDeveloperExtras -bool true

# Enable continuous spellchecking
defaults write com.apple.Safari WebContinuousSpellCheckingEnabled -bool true
# Disable auto-correct
defaults write com.apple.Safari WebAutomaticSpellingCorrectionEnabled -bool false

# Disable AutoFill
defaults write com.apple.Safari AutoFillFromAddressBook -bool false
defaults write com.apple.Safari AutoFillPasswords -bool false
defaults write com.apple.Safari AutoFillCreditCardData -bool false
defaults write com.apple.Safari AutoFillMiscellaneousForms -bool false

# Warn about fraudulent websites
defaults write com.apple.Safari WarnAboutFraudulentWebsites -bool true

# Block pop-up windows
defaults write com.apple.Safari WebKitJavaScriptCanOpenWindowsAutomatically -bool false
defaults write com.apple.Safari com.apple.Safari.ContentPageGroupIdentifier.WebKit2JavaScriptCanOpenWindowsAutomatically -bool false

###############################################################################
# Spotlight                                                                   #
###############################################################################

# Hide Spotlight through Menu Bar settings. /System is protected by SIP and
# the sealed system volume; changing the Search binary's permissions fails.
# Use `sudo mdutil -i off "/Volumes/foo"` to stop indexing a specific volume,
# or Spotlight privacy settings. The old root /.Spotlight-V100 write fails
# on modern read-only system volumes.
# Change indexing order and disable some file types
if (( macos_major < 26 )); then
defaults write com.apple.spotlight orderedItems -array \
	'{"enabled" = 1;"name" = "APPLICATIONS";}' \
	'{"enabled" = 1;"name" = "SYSTEM_PREFS";}' \
	'{"enabled" = 1;"name" = "DIRECTORIES";}' \
	'{"enabled" = 1;"name" = "PDF";}' \
	'{"enabled" = 1;"name" = "DOCUMENTS";}' \
    '{"enabled" = 1;"name" = "MENU_DEFINITION";}' \
    '{"enabled" = 1;"name" = "MENU_CONVERSION";}' \
    '{"enabled" = 1;"name" = "IMAGES";}' \
    '{"enabled" = 1;"name" = "SOURCE";}' \
    '{"enabled" = 1;"name" = "MENU_WEBSEARCH";}' \
    '{"enabled" = 1;"name" = "MENU_SPOTLIGHT_SUGGESTIONS";}' \
	'{"enabled" = 1;"name" = "PRESENTATIONS";}' \
	'{"enabled" = 1;"name" = "SPREADSHEETS";}' \
    '{"enabled" = 1;"name" = "MOVIES";}' \
    '{"enabled" = 1;"name" = "MENU_OTHER";}' \
    '{"enabled" = 1;"name" = "MENU_EXPRESSION";}' \
    '{"enabled" = 0;"name" = "FONTS";}' \
    '{"enabled" = 0;"name" = "BOOKMARKS";}' \
	'{"enabled" = 0;"name" = "MESSAGES";}' \
	'{"enabled" = 0;"name" = "CONTACT";}' \
	'{"enabled" = 0;"name" = "EVENT_TODO";}' \
	'{"enabled" = 0;"name" = "MUSIC";}'
fi
# Spotlight was redesigned in macOS 26; configure Search Results in Settings.
# Make sure indexing is enabled for the main volume
sudo mdutil -i on / > /dev/null
# Rebuild the index from scratch
sudo mdutil -E / > /dev/null

###############################################################################
# Terminal (I sync my iTerm settings via Drive)                               #
###############################################################################

# Only use UTF-8 in Terminal.app
defaults write com.apple.Terminal StringEncodings -array 4

# Use the Homebrew theme by default in Terminal.app
defaults write com.apple.Terminal "Default Window Settings" -string "Homebrew"
defaults write com.apple.Terminal "Startup Window Settings" -string "Homebrew"

# Enable Secure Keyboard Entry in Terminal.app
# See: https://security.stackexchange.com/a/47786/8918
defaults write com.apple.Terminal SecureKeyboardEntry -bool true

# Disable the annoying line marks
defaults write com.apple.Terminal ShowLineMarks -int 0

###############################################################################
# Time Machine                                                                #
###############################################################################

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

hash tmutil # speeds up execution

# Time Machine backup exclusions
for p in \
    /Applications \
    /opt/homebrew \
    "$HOME/.bundle" \
    "$HOME/.local/share/mise" \
    "$HOME/.local/share/virtualenvs" \
    "$HOME/.minikube" \
    "$HOME/.node" \
    "$HOME/.npm" \
    "$HOME/Applications" \
    "$HOME/go" \
    "$HOME/Google Drive" \
    "$HOME/ephetteplace@cca.edu - Google Drive" \
    "$HOME/phette23@gmail.com - Google Drive" \
    "$HOME/Library/Application Support/com.wizards.mtga" \
    "$HOME/Library/Caches" \
    "$HOME/Library/Containers/com.docker.docker" \
    "$HOME/Library/pnpm"; do
    sudo tmutil addexclusion -p "${p}"
done

###############################################################################
# Activity Monitor                                                            #
###############################################################################

# Show the main window when launching Activity Monitor
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in the Activity Monitor Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes in Activity Monitor
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort Activity Monitor results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0

###############################################################################
# TextEdit, Disk Utility, & QuickTime                                         #
###############################################################################

# Use plain text mode for new TextEdit documents
defaults write com.apple.TextEdit RichText -int 0
# Open and save files as UTF-8 in TextEdit
defaults write com.apple.TextEdit PlainTextEncoding -int 4
defaults write com.apple.TextEdit PlainTextEncodingForWrite -int 4

# Auto-play videos when opened with QuickTime Player
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true

###############################################################################
# Mac App Store                                                               #
###############################################################################

# The old App Store debug menu/WebKit tweaks predate its Mojave redesign.
# These legacy system-wide update preferences are best effort. macOS 27
# removes the corresponding MDM payload; verify Automatic Updates in Settings.
# Enable the automatic update check
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Install System data files & security updates
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate CriticalUpdateInstall -bool true

# Install configuration data (not apps purchased on other Macs)
sudo defaults write /Library/Preferences/com.apple.SoftwareUpdate ConfigDataInstall -bool true

# Turn on app auto-update
defaults write com.apple.commerce AutoUpdate -bool true

###############################################################################
# Photos                                                                      #
###############################################################################

# Prevent Photos from opening automatically when devices are plugged in
defaults -currentHost write com.apple.ImageCapture disableHotPlug -bool true

###############################################################################
# Messages                                                                    #
###############################################################################

# Disable automatic emoji substitution (i.e. use plain text smileys)
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticEmojiSubstitutionEnablediMessage" -bool false

# Disable smart quotes as it’s annoying for messages that contain code
defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "automaticQuoteSubstitutionEnabled" -bool false

# Disable continuous spell checking
# defaults write com.apple.messageshelper.MessageController SOInputLineSettings -dict-add "continuousSpellCheckingEnabled" -bool false

###############################################################################
# Google Chrome & Google Chrome Canary                                        #
###############################################################################

# Disable the all too sensitive backswipe on trackpads
defaults write com.google.Chrome AppleEnableSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableSwipeNavigateWithScrolls -bool false

# Disable the all too sensitive backswipe on Magic Mouse
defaults write com.google.Chrome AppleEnableMouseSwipeNavigateWithScrolls -bool false
defaults write com.google.Chrome.canary AppleEnableMouseSwipeNavigateWithScrolls -bool false

# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true
defaults write com.google.Chrome.canary DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true
defaults write com.google.Chrome.canary PMPrintingExpandedStateForPrint2 -bool true

###############################################################################
# Kill affected applications                                                  #
###############################################################################

hash killall

for app in "Calendar" \
    "Contacts" \
    "Dock" \
    "Finder" \
    "Google Chrome Canary" \
    "Google Chrome" \
    "Photos" \
    "Safari" \
    "SystemUIServer"; do
	killall "$app" > /dev/null 2>&1
done

# Do not kill Terminal (it may be running this script) or the Bluetooth daemon.

# load tldr index
[ -n "$(command -v tldr)" ] && tldr --update

# https://github.com/MikeMcQuaid/dotfiles/blob/master/bin/touchid-enable-pam-sudo
if [ -f /etc/pam.d/sudo_local.template ] && [ ! -f /etc/pam.d/sudo_local ]; then
    sudo cp /etc/pam.d/sudo_local.template /etc/pam.d/sudo_local
    sudo sed -i '' '/pam_tid\.so/s/^#//' /etc/pam.d/sudo_local
fi

echo "Done! Some changes require a logout/restart to take effect."
echo "Also, don't forget to add '%admin ALL=(ALL) NOPASSWD: /usr/sbin/softwareupdate' to /etc/sudoers so you don't have to type your password when running the upd alias."
echo "Run 'sudo visudo /etc/sudoers' to edit the file."
