#
# Be sure to run `pod lib lint GradientProgressBar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GradientProgressBar'
  s.version          = '2.1.0'
  s.summary          = 'A customizable gradient progress bar (UIProgressView).'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A gradient progress bar (UIProgressView).
Inspired by https://codepen.io/marcobiedermann/pen/LExXWW
                       DESC

  s.homepage         = 'https://github.com/fxm90/GradientProgressBar'
  s.screenshots      = 'https://raw.githubusercontent.com/fxm90/GradientProgressBar/master/Assets/example.png'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Felix Mau' => 'me@felix.hamburg' }
  s.source           = { :git => 'https://github.com/fxm90/GradientProgressBar.git', :tag => s.version.to_s }

  s.swift_version         = '5.5'
  s.ios.deployment_target = '9.0'

  s.source_files = 'GradientProgressBar/**/*'

  # s.resource_bundles = {
  #   'GradientProgressBar' => ['GradientProgressBar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'LightweightObservable', '~> 2.1'

end
