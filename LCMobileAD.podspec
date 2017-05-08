Pod::Spec.new do |s|
  s.platform = :ios, "8.0"
  s.name     = 'LCMobileAD'
  s.version  = '1.1.2'
  s.license  = 'MIT'
  s.summary  = 'ad SDK.'
  s.homepage = 'https://github.com/LoveDou/LCMobileAD'
  s.authors  = { 'LoveDou' => 'luochao@altamob.com' }
  s.source   = { :git => 'https://github.com/LoveDou/LCMobileAD.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.source_files = 'LCAdSDK/AltamobAdSDK.framework/*.h'
  s.resource = 'LCAdSDK/AltamobAdSDK.framework'
  s.dependency  'FBAudienceNetwork'
end