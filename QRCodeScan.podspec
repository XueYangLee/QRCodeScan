#
# Be sure to run `pod lib lint QRCodeScan.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QRCodeScan'
  s.version          = '1.0.0'
  s.summary          = '扫描组件'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
扫描组件
                       DESC

  s.homepage         = 'https://github.com/XueYangLee/QRCodeScan'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Singularity_Lee' => '496736912@qq.com' }
  s.source           = { :git => 'https://github.com/XueYangLee/QRCodeScan.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'QRCodeScan/Classes/*.{h,m}'
#  s.resources = ['QRCodeScan/Assets/**/*.*']
   s.resource_bundles = {
     'QRCodeScan' => ['QRCodeScan/Assets/**/*.*']
   }

   s.public_header_files = 'QRCodeScan/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
