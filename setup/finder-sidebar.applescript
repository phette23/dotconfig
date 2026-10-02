-- Use Finder's controls instead of editing its version-dependent sidebar files.
-- Run with folder paths as arguments; Finder handles existing favorites.
-- Requires an English Finder UI and Accessibility/Automation permission for
-- the terminal running osascript. Does not delete folders or disable services.

on run folderPaths
    tell application "Finder" to activate
    tell application "System Events"
        if not UI elements enabled then
            error "Enable Accessibility access for your terminal in System Settings > Privacy & Security > Accessibility, then rerun the sidebar setup."
        end if
        tell process "Finder"
            set frontmost to true
            keystroke "," using command down
        end tell
    end tell

    -- Settings used a tab group on older macOS and toolbar buttons on others.
    set sidebarTab to missing value
    repeat 50 times
        tell application "System Events" to tell process "Finder"
            if exists window 1 then
                set settingsWindow to window 1
                set sidebarTab to my findSidebarTab(settingsWindow)
            end if
        end tell
        if sidebarTab is not missing value then exit repeat
        delay 0.2
    end repeat
    if sidebarTab is missing value then error "Could not find Finder Settings > Sidebar. This helper expects English UI labels."
    tell application "System Events" to click sidebarTab

    -- Wait for the pane to finish loading before looking for its checkboxes.
    set sidebarReady to false
    repeat 50 times
        tell application "System Events" to set paneElements to entire contents of settingsWindow
        repeat with uiElement in paneElements
            tell application "System Events" to set elementRole to role of uiElement
            if elementRole is "AXCheckBox" then
                if my elementLabel(uiElement) is "Movies" then set sidebarReady to true
            end if
        end repeat
        if sidebarReady then exit repeat
        delay 0.2
    end repeat
    if not sidebarReady then error "Finder Sidebar checkboxes did not load; sidebar configuration was not applied."

    -- Recent tags is the checkbox controlling the Tags section. Bonjour may
    -- be absent on newer releases, and iCloud labels depend on account state.
    set unwantedItems to {{"Movies"}, {"Pictures"}, {"Shared"}, {"iCloud Drive"}, {"iCloud Storage"}, {"AirDrop"}, {"Bonjour computers", "Bonjour"}, {"Recent tags", "Tags"}}
    repeat with itemLabels in unwantedItems
        set foundCheckbox to false
        tell application "System Events" to set paneElements to entire contents of settingsWindow
        repeat with uiElement in paneElements
            tell application "System Events" to set elementRole to role of uiElement
            if elementRole is "AXCheckBox" then
                if my elementLabel(uiElement) is in itemLabels then
                    set foundCheckbox to true
                    tell application "System Events"
                        if value of uiElement is 1 then click uiElement
                    end tell
                    repeat 25 times
                        tell application "System Events" to set checkboxValue to value of uiElement
                        if checkboxValue is 0 then exit repeat
                        delay 0.2
                    end repeat
                    if checkboxValue is not 0 then error "Could not uncheck sidebar item: " & my elementLabel(uiElement)
                end if
            end if
        end repeat
        if not foundCheckbox then log "Sidebar checkbox not present on this Mac: " & item 1 of itemLabels
    end repeat
    tell application "System Events" to tell process "Finder" to keystroke "w" using command down

    repeat with folderPath in folderPaths
        set folderAlias to POSIX file (contents of folderPath) as alias
        tell application "Finder"
            reveal folderAlias
            activate
        end tell
        -- Reveal is asynchronous; wait until the intended folder is selected.
        set folderSelected to false
        repeat 50 times
            tell application "Finder" to set selectedItems to selection
            if (count selectedItems) is 1 then
                tell application "Finder" to set selectedAlias to item 1 of selectedItems as alias
                if selectedAlias is folderAlias then set folderSelected to true
            end if
            if folderSelected then exit repeat
            delay 0.2
        end repeat
        if not folderSelected then error "Finder could not select sidebar folder: " & folderPath
        tell application "System Events" to tell process "Finder"
            set frontmost to true
            -- Finder disables this item when the folder is already a favorite.
            set addItem to menu item "Add to Sidebar" of menu "File" of menu bar 1
            if enabled of addItem then click addItem
        end tell
    end repeat
end run

on findSidebarTab(settingsWindow)
    tell application "System Events" to set uiElements to entire contents of settingsWindow
    repeat with uiElement in uiElements
        tell application "System Events" to set elementRole to role of uiElement
        if elementRole is in {"AXRadioButton", "AXButton"} then
            if my elementLabel(uiElement) is "Sidebar" then return contents of uiElement
        end if
    end repeat
    return missing value
end findSidebarTab

on elementLabel(uiElement)
    tell application "System Events"
        set elementName to name of uiElement
        if elementName is not missing value and elementName is not "" then return elementName
        return description of uiElement
    end tell
end elementLabel
