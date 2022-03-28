// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

#if os(macOS)
  import AppKit
#elseif os(iOS)
  import UIKit
#elseif os(tvOS) || os(watchOS)
  import UIKit
#endif

// Deprecated typealiases
@available(*, deprecated, renamed: "ColorAsset.Color", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetColorTypeAlias = ColorAsset.Color
@available(*, deprecated, renamed: "ImageAsset.Image", message: "This typealias will be removed in SwiftGen 7.0")
internal typealias AssetImageTypeAlias = ImageAsset.Image

// swiftlint:disable superfluous_disable_command file_length implicit_return

// MARK: - Asset Catalogs

// swiftlint:disable identifier_name line_length nesting type_body_length type_name
internal enum Assets {
  internal static let accentColor = ColorAsset(name: "AccentColor")
  internal static let group6796 = ImageAsset(name: "Group 6796")
  internal static let group6890 = ImageAsset(name: "Group 6890")
  internal static let group6891 = ImageAsset(name: "Group 6891")
  internal static let group7034 = ImageAsset(name: "Group 7034")
  internal static let authMainLogo = ImageAsset(name: "authMainLogo")
  internal static let authSplashScreen = ImageAsset(name: "authSplashScreen")
  internal static let avatarDefaulth = ImageAsset(name: "avatarDefaulth")
  internal static let password = ImageAsset(name: "password")
  internal static let cameraBack = ImageAsset(name: "Camera_back")
  internal static let light = ImageAsset(name: "Light")
  internal static let lightOff = ImageAsset(name: "Light_off")
  internal static let cameraSwap = ImageAsset(name: "cameraSwap")
  internal static let closeButton = ImageAsset(name: "closeButton")
  internal static let info = ImageAsset(name: "info")
  internal static let infoCamera = ImageAsset(name: "infoCamera")
  internal static let photoIcon = ImageAsset(name: "photo_icon")
  internal static let filterButton = ImageAsset(name: "FilterButton")
  internal static let searchIcon = ImageAsset(name: "Search Icon")
  internal static let crossIcon = ImageAsset(name: "crossIcon")
  internal static let moreBlackBottom = ImageAsset(name: "moreBlackBottom")
  internal static let blackText = ColorAsset(name: "BlackText")
  internal static let border = ColorAsset(name: "Border")
  internal static let borderButton = ColorAsset(name: "BorderButton")
  internal static let classicBGGray = ColorAsset(name: "ClassicBGGray")
  internal static let darkBlueText = ColorAsset(name: "DarkBlueText")
  internal static let darkGrayText = ColorAsset(name: "DarkGrayText")
  internal static let darkRedPageControll = ColorAsset(name: "DarkRedPageControll")
  internal static let lightGray = ColorAsset(name: "LightGray")
  internal static let mainRed = ColorAsset(name: "MainRed")
  internal static let whiteText = ColorAsset(name: "WhiteText")
  internal static let backButton = ImageAsset(name: "BackButton")
  internal static let close = ImageAsset(name: "Close")
  internal static let more = ImageAsset(name: "more")
  internal static let moreBlack = ImageAsset(name: "moreBlack")
  internal static let chevronUp = ImageAsset(name: "chevronUp")
  internal static let comments = ImageAsset(name: "comments")
  internal static let dot = ImageAsset(name: "dot")
  internal static let emptyHeart = ImageAsset(name: "emptyHeart")
  internal static let filledHeart = ImageAsset(name: "filledHeart")
  internal static let playButton = ImageAsset(name: "playButton")
  internal static let onb1 = ImageAsset(name: "onb1")
  internal static let onb2 = ImageAsset(name: "onb2")
  internal static let onb3 = ImageAsset(name: "onb3")
  internal static let moreHorizontal = ImageAsset(name: "more_horizontal")
  internal static let arrorwBlack = ImageAsset(name: "arrorw_black")
  internal static let addUnselected = ImageAsset(name: "addUnselected")
  internal static let chatSelected = ImageAsset(name: "chatSelected")
  internal static let chatUnselected = ImageAsset(name: "chatUnselected")
  internal static let feedSelected = ImageAsset(name: "feedSelected")
  internal static let feedUnselected = ImageAsset(name: "feedUnselected")
  internal static let searchSelected = ImageAsset(name: "searchSelected")
  internal static let searchUnselected = ImageAsset(name: "searchUnselected")
  internal static let checkIcon = ImageAsset(name: "CheckIcon")
  internal static let dismissSubstract24 = ImageAsset(name: "dismiss_substract_24")
}
// swiftlint:enable identifier_name line_length nesting type_body_length type_name

// MARK: - Implementation Details

internal final class ColorAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Color = NSColor
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Color = UIColor
  #endif

  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  internal private(set) lazy var color: Color = {
    guard let color = Color(asset: self) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }()

  #if os(iOS) || os(tvOS)
  @available(iOS 11.0, tvOS 11.0, *)
  internal func color(compatibleWith traitCollection: UITraitCollection) -> Color {
    let bundle = BundleToken.bundle
    guard let color = Color(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load color asset named \(name).")
    }
    return color
  }
  #endif

  fileprivate init(name: String) {
    self.name = name
  }
}

internal extension ColorAsset.Color {
  @available(iOS 11.0, tvOS 11.0, watchOS 4.0, macOS 10.13, *)
  convenience init?(asset: ColorAsset) {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSColor.Name(asset.name), bundle: bundle)
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

internal struct ImageAsset {
  internal fileprivate(set) var name: String

  #if os(macOS)
  internal typealias Image = NSImage
  #elseif os(iOS) || os(tvOS) || os(watchOS)
  internal typealias Image = UIImage
  #endif

  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, macOS 10.7, *)
  internal var image: Image {
    let bundle = BundleToken.bundle
    #if os(iOS) || os(tvOS)
    let image = Image(named: name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    let name = NSImage.Name(self.name)
    let image = (bundle == .main) ? NSImage(named: name) : bundle.image(forResource: name)
    #elseif os(watchOS)
    let image = Image(named: name)
    #endif
    guard let result = image else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }

  #if os(iOS) || os(tvOS)
  @available(iOS 8.0, tvOS 9.0, *)
  internal func image(compatibleWith traitCollection: UITraitCollection) -> Image {
    let bundle = BundleToken.bundle
    guard let result = Image(named: name, in: bundle, compatibleWith: traitCollection) else {
      fatalError("Unable to load image asset named \(name).")
    }
    return result
  }
  #endif
}

internal extension ImageAsset.Image {
  @available(iOS 8.0, tvOS 9.0, watchOS 2.0, *)
  @available(macOS, deprecated,
    message: "This initializer is unsafe on macOS, please use the ImageAsset.image property")
  convenience init?(asset: ImageAsset) {
    #if os(iOS) || os(tvOS)
    let bundle = BundleToken.bundle
    self.init(named: asset.name, in: bundle, compatibleWith: nil)
    #elseif os(macOS)
    self.init(named: NSImage.Name(asset.name))
    #elseif os(watchOS)
    self.init(named: asset.name)
    #endif
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
