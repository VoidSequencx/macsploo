#!/bin/bash

main() {
    echo -e "Downloading JSON Parser"
    curl "https://cdn.discordapp.com/attachments/1000184107281690696/1154250203650605107/jq-macos-amd64" -o "./jq"
    chmod +x ./jq

    echo -e "Downloading Latest Roblox"
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    local version=$(curl -s "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer" | ./jq -r ".clientVersionUpload")
    curl "http://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" -o "./RobloxPlayer.zip"
    rm ./jq

    echo -e "Installing Latest Roblox"
    [ -d "/Users/a/Applications/Roblox.app" ] && rm -rf "/Users/a/Applications/Roblox.app"
    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Users/a/Applications/Roblox.app
    rm ./RobloxPlayer.zip

    echo -e "Downloading MacSploit"
    curl "https://cdn.discordapp.com/attachments/1145711068291805315/1198035291986993192/MacSploit.zip" -o "./MacSploit.zip"

    echo -e "Installing MacSploit"
    unzip -o -q "./MacSploit.zip"

    echo -e "Patching Roblox"
    mv ./macsploit.dylib "/Users/a/Applications/Roblox.app/Contents/MacOS/macsploit.dylib"
    ./insert_dylib "/Users/a/Applications/Roblox.app/Contents/MacOS/macsploit.dylib" "/Users/a/Applications/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    mv "/Users/a/Applications/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Users/a/Applications/Roblox.app/Contents/MacOS/RobloxPlayer"
    rm ./insert_dylib

    echo -e "Installing MacSploit App"
    [ -d "/Users/a/Applications/MacSploit.app" ] && rm -rf "/Users/a/Applications/MacSploit.app"
    mv ./MacSploit.app /Users/a/Applications/MacSploit.app
    rm ./MacSploit.zip

    chmod +x ./hwid
    ./hwid && rm ./hwid
    echo -e "Please whitelist your hwid through contacting support in a ticket if you haven't already!"
    echo -e "Install Complete! Developed by Nexus42!"
}

main
