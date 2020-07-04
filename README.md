# QuertyKeyboard

Simulate key presses from a US qwerty keyboard on macOS

## Usage

Trigger a key press

```swift
QuertyKeyboard().press(key: .up)
```

Trigger a key press with modifiers

```swift
QuertyKeyboard().press(key: .c, withModifiers: [.control])
```

Trigger multiple key presses with shift modifier for each character in the string.  Characters not found on the keyboard are ignored.

```swift
QuertyKeyboard().type(string: "This is an example of typing! ;-)")
```

## Additional information

[CKKeyCode](https://stackoverflow.com/a/16125341/1721611)

When  app sandbox is enabled the following usage description might be required required.

[Privacy - AppleEvents Sending Usage Description](https://developer.apple.com/documentation/bundleresources/information_property_list/nsappleeventsusagedescription)

