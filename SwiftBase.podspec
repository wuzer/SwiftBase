#
# Be sure to run `pod lib lint SwiftBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SwiftBase'
  s.version          = '0.1.2'
  s.summary          = 'A base object extension for swift'

  s.description      = <<-DESC
  A base object extension for swift, useful!
                       DESC

  s.homepage         = 'https://github.com/wuzer/SwiftBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Jefferson' => 'eazyyer@gmail.com' }
  s.source           = { :git => 'https://github.com/wuzer/SwiftBase.git', :tag => s.version.to_s }
  s.swift_version = '4.0'
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'SwiftBase/Classes/**/*'
  
  # s.resource_bundles = {
  #   'SwiftBase' => ['SwiftBase/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Kingfisher'
end
