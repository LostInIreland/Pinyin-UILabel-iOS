#
# Be sure to run `pod lib lint PinyinLabelExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PinyinLabelExtension'
  s.version          = '0.1.0'
  s.swift_version    = '4.2'
  s.summary          = 'An iOS custom UILabel that can display Chinese pinyin with tone above.'

  s.description      = <<-DESC
An iOS custom UILabel that can display Chinese pinyin with tone above.
It take 1, 2, 3, 4 as the tone value after the pinyin.
                       DESC

  s.homepage         = 'https://github.com/LostInIreland/Pinyin-UILabel-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lost In Ireland' => 'edward.money@hotmail.com' }
  s.source           = { :git => 'https://github.com/LostInIreland/Pinyin-UILabel-iOS.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  
  s.source_files = 'PinyinLabelExtension/Classes/**/*'
  
  # s.resource_bundles = {
  #   'PinyinLabelExtension' => ['PinyinLabelExtension/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
