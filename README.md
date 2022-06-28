# YassirTask

A simple UIKit app that displays movies using TheMoviesDB APIs.

# Screens 

* Movies list screen.
* Movie details screen.

# Technologies

* UIKit
* RXSwift/RXCocoa
* MVVM
* CoreData
* Unit Testing

# Development Target Pods 

* RxSwift/RxCocoa

# Testing Target Pods

* RxTest

# Requirements

* iOS 13.1 or later.
* Xcode 13.0 or later.

# Installation
Dependencies in this project are provided via Cocoapods and i already pushed them inside the github repo so you can easily download the repo as a .zipFile
and run the project directily usin xcode.
but if you faced any issue due to xcode or podfile.lock incompatibility you can do the following:
* download code as a ZIP. 
* delete pods folder.
* delete podfile.lock.
* delete .xcworkspace file.
* install all dependecies with 
```pod install```
* if you are using Macbook M1, maybe you will face an error while executing the previous command, so you can try the following commands
```
sudo arch -x86_64 gem install ffi
arch -x86_64 pod install
```
# Screenshots

<img src="https://user-images.githubusercontent.com/61560211/176118924-b280a915-e163-4931-81ad-abc612cbe233.png" width="352" height="817">  <img src="https://user-images.githubusercontent.com/61560211/176119262-65eab7ec-0848-4d33-b545-03a92c8d421b.png" width="352" height="817">

# Author
[Zeyad Badawy](https://www.linkedin.com/in/zeyadbadawy/)


