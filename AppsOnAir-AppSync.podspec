#
# Be sure to run `pod lib lint AppsOnAir-AppSync.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppsOnAir-AppSync'
  s.version          = '0.1.0'
  s.summary          = 'AppsOnAir-AppSync is library for managing app updates and its maintenance.'

  s.description      = 'AppsOnAir-AppSync is library for managing app updates and its maintenance. It will handle from out web portal.'

  s.homepage         = 'https://documentation.appsonair.com/Mobile-Quickstart/ios-sdk-setup'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'devtools-logicwind' => 'devtools@logicwind.com' }
  s.source           = { :git => 'https://github.com/apps-on-air/AppsOnAir-iOS-AppSync.git', :tag => s.version.to_s }

  s.swift_version  = '5.0'
  s.ios.deployment_target = '12.0'

  # Access the all the UI File within the pod 
  s.resources = ['AppsOnAir-AppSync/Assets/**/*'] # for access SwiftUI  inside AppSync

  s.source_files = 'AppsOnAir-AppSync/Classes/**/*'
  
  # AppsOnAir Core pod
  s.dependency 'AppsOnAir-Core'
 
end
