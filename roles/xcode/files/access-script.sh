sudo sqlite3 /Library/Application\ Support/com.apple.TCC/TCC.db \
    "INSERT or REPLACE INTO access(service,client,client_type,allowed,prompt_count) VALUES('kTCCServiceAccessibility','/usr/libexec/sshd-keygen-wrapper',1,1,1);"

osascript <<EOD
tell application "System Events"
  tell application "Finder" to activate
  repeat while (value of attribute "AXfocused" of group 1 of scroll area of ¬
     process "Finder" is {false})
        keystroke "<" using command down
  end repeat
end tell
EOD
