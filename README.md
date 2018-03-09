# HenriPotierApiClient

Look at [reference](https://rokridi.github.io/HenriPotierApiClient/) for more details.

## Features

* Fetch Henri Potier books.
* Get offers for books.

## Requirements

* iOS 11.0+
* XCode 9+
* Swift 4.0+

## Installation
### CocoaPods

[CocoaPods](http://cocoapods.org/) is a dependency manager for Cocoa projects. You can install it with the following command:

```
$ gem install cocoapods
```

To integrate BantuDicoAlamofireApiClient into your Xcode project using CocoaPods, specify it in your ```Podfile```:

```
platform :ios, '11.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'HenriPotierApiClient', :git=> 'https://github.com/rokridi/HenriPotierApiClient.git'
end
```
Then, run the following command:
```
$ pod install
```

## Usage

### Fetch books.

```
let client = HenriPotierApiClient(configuration: URLSessionConfiguration.default, baseURL: "http://www.domain.com")
        
client.books() { result  in
  switch result {
    case .success(let books):
    case .failure(let error):
  }
}
```

### Get offers for books ISBNs.

```
let client = HenriPotierApiClient(configuration: URLSessionConfiguration.default, baseURL: "http://www.domain.com")
        
apiClient.offers(ISBNs: ["c8fabf68-8374-48fe-a7ea-a00ccd07afff", "a460afed-e5e7-4e39-a39d-c885c05db861"]) { result  in
  switch result {
    case .success(let offers):
    case .failure(let error):
  }
}                    
```

