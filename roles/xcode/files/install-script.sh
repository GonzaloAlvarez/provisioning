if [[ "$(xcode-select -p)" == "" ]]; then
  printf "\n### Installing Xcode command line tools\n"
  xcode-select --install
  sleep 2
  osascript <<EOD
    tell application "System Events"
      tell process "Install Command Line Developer Tools"
        click button "Install" of window ""
        click button "Agree" of window "License Agreement"
        repeat until exists button "Done" of window ""
          delay 1
        end repeat
        click button "Done" of window ""
      end tell
    end tell
EOD
fi
