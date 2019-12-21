#
# Be sure to run `pod lib lint GametacSDK.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GametacSDK'
  s.version          = '1.1.5'
  s.summary          = 'GametacSDK.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/rstakaiito/GametacSDK'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'rstakaiito' => 'vietcuong.it@gmail.com' }
  s.source           = { :git => 'https://github.com/rstakaiito/GametacSDK.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.static_framework = true
  
  s.ios.deployment_target = '11.0'
  s.swift_version = '4.2'

  s.source_files = 'GametacSDK/Classes/**/*'
  
  #s.resource_bundles = {
  #    'GametacSDK' => ['GametacSDK/Assets.xcassets/**/*']
  #}

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'PopupDialog'
  s.dependency 'Kingfisher'
  s.dependency 'XLPagerTabStrip'
  s.dependency 'FBSDKShareKit'
  s.dependency 'FBSDKCoreKit'
  s.dependency 'FBSDKLoginKit'
  s.dependency 'GoogleSignIn'
  s.dependency 'Firebase'
  s.dependency 'Firebase/Auth'
  s.dependency 'KMPlaceholderTextView'
  s.dependency 'DKImagePickerController'
  s.dependency 'NVActivityIndicatorView'
end
