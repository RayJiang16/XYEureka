
Pod::Spec.new do |s|
  s.name             = 'XYEureka'
  s.version          = '1.0.0'
  s.summary          = 'Extension of Eureka'

  s.homepage         = 'https://github.com/RayJiang16/XYEureka'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'RayJiang' => '1184731421@qq.com' }
  s.source           = { :git => 'https://github.com/RayJiang16/XYEureka', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'Sources/Core/**/*.swift'

  s.frameworks = 'UIKit'
  s.frameworks = 'Eureka'
  s.frameworks = 'SnapKit'

end
