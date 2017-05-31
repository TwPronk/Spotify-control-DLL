A DLL that gives basic control over Spotify by sending messages to Windows.

# Exported functions

## xNew: Returns HWND
xNew returns the windows handle for the spotify window.
This handle is required for all other functions.

## PlayPause: void
Sends a message to the window simulating a button press on the play/pause button.

## Stop: void
Sends a message to the window simulating a button press on the Stop button.

## Next: void
Sends a message to the window simulating a button press on the Next button.

## Previous: void
Sends a message to the window simulating a button press on the Previous button.

## VolDown: void
Sends a message to the window simulating a button press on the Volume down button.
Note, this affects windows volume, not the volume in Spotify

## VolUp: void
Sends a message to the window simulating a button press on the Volume up button.
Note, this affects windows volume, not the volume in Spotify

## Mute: void
Sends a message to the window simulating a button press on the Mute button.
Note, this affects windows volume, not the volume in Spotify

## Info: PChar
Uses the windowhandle to retrieve the windowtext which contains the artist and title of the currently played song.
