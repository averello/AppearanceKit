#
# Be sure to run `pod lib lint AppearanceKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AppearanceKit'
  s.version          = '2.21'
  s.summary          = 'Change the appearance of UIKit elements.'

  s.description      = <<-DESC
Change the appearance of UIKit elements, using classes that declaratively
describe the appearance.
                       DESC

  s.homepage         = 'https://github.com/averello/AppearanceKit'
  s.license          = { :type => 'Apache 2.0', :file => 'LICENSE' }
  s.author           = { 'Georges Boumis' => 'developer.george.boumis@gmail.com' }
  s.source           = { :git => 'https://github.com/averello/AppearanceKit.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'
  s.source_files = 'AppearanceKit/Classes/**/*'
  s.dependency 'ContentKit' 
  s.dependency 'RepresentationKit' 
end
