# BarcodeView

**BarcodeView** is a beautiful and simple to use SwiftUI barcode view for Apple platforms.

## Getting Started

BarcodeView uses the Swift Package Manager. To include it in your project, add `BarcodeView` as a swift package dependency in XCode and import `BarcodeView` in any files that need to use it.

## Using BarcodeView

### Create a barcode

Showing barcodes couldn't be easier with `BarcodeView`. First, create your `Barcode` using the `BarcodeFactory`:

```swift
// validate using the checksum digit
guard let barcode = BarcodeFactory.barcode(from: "302993918288") else {
    // invalid barcode
}

// don't worry about whether it's real, you want to display something barcode-like
guard let barcode = BarcodeFactory.barcode(from: "1234567890123", verifyChecksum: false) else {
    // this can only be invalid if you don't have the proper number of digits now
}
```

### Create the view

Now that you have a barcode, create your `BarcodeView` and give it a height:

```swift
var body: some View {
    BarcodeView(barcode)
        .frame(height: 120)
}
```

!["Default barcode"](/Documentation/Barcode.png)

### Customize it

By default, each bar (either clear or foreground color) is `2` points wide. Want to customize it? Change the `environment`:

```swift
var body: some View {
    BarcodeView(barcode)
        .frame(height: 60)
        .environment(\.barWidth, 1)
}
```

!["bar width modified barcode"](/Documentation/BarWidth.png)

Want to change the color? Do it the normal SwiftUI way, using `foregroundColor`:

```swift
var body: some View {
    BarcodeView(barcode)
        .frame(height: 120)
        .foregroundColor(.purple)
}
```

!["purple colored barcode"](/Documentation/ForegroundColor.png)

If the text doesn't fit your design, get rid of it:

```swift
var body: some View {
    BarcodeView(barcode, showText: false)
        .frame(height: 60)
}
```

!["no text barcode"](/Documentation/HideText.png)

## What's supported

Currently `BarcodeView` supports the following barcode formats:

* UPCA (12 digits)
* EAN13 (13 digits)

In addition, `BarcodeView` supports light and dark modes, but if you care about actual scannability, don't use dark mode. It looks cool but it's the opposite of what scanners are looking for.

## Want to help?

Create an issue and submit a PR against that issue. Areas I would love to see improved are:

 * Add support for additional barcodes, like EAN8 and UPC-E
 * Simplify the cutout and text display code

## Have questions?

Create an issue or hit me up on [Twitter](https://twitter.com/naterivard)
