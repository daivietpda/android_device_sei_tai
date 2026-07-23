# B08 Bluetooth voice remote (VID 7545, PID 017e).
# Mark the HID input device as microphone-capable so Android TV can pass the
# associated hidraw audio file descriptor to the voice interaction service.

keyboard.doNotWakeByDefault = 1
audio.mic = 1
