#
# Be sure to run `pod lib lint QVCloudEngine.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QVCloudEngine'
  s.version          = '1.1.22'
  s.summary          = 'A short description of QVCloudEngine.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/QuVideoDeveloper/CloudEngine-iOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'QuVideo Inc.' => 'Githubgitsource@quvideo.com' }
  s.source           = { :git => 'https://github.com/QuVideoDeveloper/CloudEngine-iOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'QVCloudEngine/Classes/**/*'
  s.vendored_frameworks = 'QVCloudEngine/FrameWork/QVCloudEngineSDK.framework'
  
  s.libraries = 'resolv'
  
  s.frameworks = 'CoreServices', 'AVFoundation' , 'Photos' , 'SystemConfiguration' , 'CoreTelephony' , 'CoreGraphics' , 'CoreMedia'
  s.static_framework = true
  s.dependency 'AliyunOSSiOS', '2.10.7'
  s.dependency 'AWSS3', '2.10.0'
  s.dependency 'AWSCore', '2.10.0'
  s.dependency 'QVCommonKit/Core'
  s.xcconfig = { "OTHER_LDFLAGS" => "-ObjC" }

  # s.resource_bundles = {
  #   'QVCloudEngine' => ['QVCloudEngine/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
