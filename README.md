![alt text](https://github.com/charvoa/TimberiOS/blob/master/Logo-TimberiOS-Cocoapod.png?raw=true)
# TimberiOS

[![CI Status](http://img.shields.io/travis/charvoa/TimberiOS.svg?style=flat)](https://travis-ci.org/charvoa/TimberiOS)
[![Version](https://img.shields.io/cocoapods/v/TimberiOS.svg?style=flat)](http://cocoapods.org/pods/TimberiOS)
[![License](https://img.shields.io/cocoapods/l/TimberiOS.svg?style=flat)](http://cocoapods.org/pods/TimberiOS)
[![Platform](https://img.shields.io/cocoapods/p/TimberiOS.svg?style=flat)](http://cocoapods.org/pods/TimberiOS)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

> CocoaPods 1.1+ is required to build TimberiOS.

To integrate TimberiOS into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

target '<Your Target Name>' do
pod 'TimberiOS'
end
```

Then, run the following command:

```bash
$ pod install
```

## Logged Properties

- [X] dt
- [X] level
- [X] severity
- [X] message
- [X] tags
- [X] runtime (`application - class-name`)
- [ ] time_ms
- [ ] context
- [ ] organization
- [ ] platform (logged in `runtime - applcation - class-name`)
- [ ] release
- [ ] runtime (only `application - class-name` (see above) )
- [ ] session
- [ ] source
- [ ] system
- [ ] user
- [ ] event
- [ ] custom
- [ ] error
- [ ] More ...

  ## Usage
  
  ### Logging level
  
  The level defined here are the ones defined in Timber
  
  ```swift
  
  public enum LogLevel: String {
      case debug = "debug"
      case info = "info"
      case notice = "notice"
      case warn = "warn"
      case error = "error"
      case critical = "critical"
      case alert = "alert"
      case emergency = "emergency"
  }
  
  ```
  
  ### Logging type
  
  The type defined here are the ones defined in Timber
  
  ```swift
  
  public enum LogType: String {
      case frame = "/frames"
      case alert = "/alert"
  }
  
  ```
  
  ### Severity
  
  The severity is the level of severity of the log. As defined in Timber, it must be between 0 and 7. The app will crash if the severity is higher or lower. 
  
  ### Initialization
  
  `AppDelegate.swift :`
  
  ```swift
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      // Override point for customization after application launch.
  
      TimberLogger.initialize(with: "YOUR_TIMBER_API_KEY", internalLogLevel: .InternalLogLevel)
      return true
  }
  
  ```
  
  ### InternalLogLevel
  
  This enum is here to help your console dealing with logs. It will only print logs when the LogLevel is >= than the InternalLogLevel
  
  ```swift
  public enum InternalLogLevel: String {
      case debugInternal
      case warnInternal
      case criticalInternal
  }
  
  private static let debugLevelArray: [LogLevel] = [.debug, .info, .notice, .warn, .error, .critical, .alert, .emergency]
  private static let warnLevelArray: [LogLevel]  = [.warn, .error, .critical, .alert, .emergency]
  private static let criticalLevelArray: [LogLevel]  = [.critical, .alert, .emergency]
  
  ```
  
  ### Logging
  
  `AppDelegate.swift :`
  
  ```swift
  
  override func viewDidLoad() {
      super.viewDidLoad()
      TimberLogger.shared.log(type: .frame, level: .info, severity:2, tags:[], message: "viewDidLoad")
      // Do any additional setup after loading the view, typically from a nib.
  }
  
  ```
  
 ## Author

Nicolas Charvoz, charvoz.nicolas@gmail.com

## Timber.io

You can create your account and get your own API key on : [Timber.io](https://timber.io/)

## License

TimberiOS is available under the MIT license. See the LICENSE file for more info.
