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
  s.summary          = 'A short description of AppsOnAir-AppSync.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/164989979/AppsOnAir-AppSync'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '164989979' => 'harshil.gandhi@logicwind.com' }
  s.source           = { :git => 'https://github.com/164989979/AppsOnAir-AppSync.git', :tag => s.version.to_s }

  s.swift_version  = '5.0'
  s.ios.deployment_target = '12.0'

  # Access the all the UI File within the pod 
  s.resources = ['AppsOnAir-AppSync/Assets/**/*'] # for access SwiftUI  inside ForceUpdate

  s.source_files = 'AppsOnAir-AppSync/Classes/**/*'
  
  # AppsOnAir Core pod
  s.dependency 'AppsOnAir-Core', '~> 0.0.1'
 
end
