#
# Be sure to run `pod lib lint TimberiOS.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TimberiOS'
  s.version          = '0.1.0'
  s.summary          = 'TimberiOS is here to help you log iOS record direclty in Timber'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'That is a long description'

  s.homepage         = 'https://github.com/charvoa/TimberiOS'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'charvoa' => 'charvoz.nicolas@gmail.com' }
  s.source           = { :git => 'https://github.com/charvoa/TimberiOS.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/NicolasCharvoz'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TimberiOS/Classes/**/*'

  # s.resource_bundles = {
  #   'TimberiOS' => ['TimberiOS/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Alamofire'
end
