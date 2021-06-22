#
# Be sure to run `pod lib lint JKSegment.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JKSegment'
  s.version          = '1.0.0'
  s.summary          = '多页面滑动控件'

  s.homepage         = 'https://github.com/lwq718691587/JKSegment'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liuweiqiang' => 'liuweiqiang@jianke.com' }
  s.source           = { :git => 'https://github.com/lwq718691587/JKSegment.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'JKSegment/**/*'
  
end
