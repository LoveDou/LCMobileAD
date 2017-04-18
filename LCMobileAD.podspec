Pod::Spec.new do |s|
  s.name     = 'LCMobileAD'
  s.version  = '1.0.1'
  s.license  = 'MIT'
  s.summary  = 'ad SDK.'
  s.homepage = 'https://github.com/LoveDou/LCMobileAD'
  s.authors  = { 'LoveDou' => 'luochao@altamob.com' }
  s.source   = { :git => 'https://github.com/LoveDou/LCMobileAD.git', :tag => s.version, :submodules => true }
  s.requires_arc = true
  s.resource = 'LCAdSDK/AltamobAdSDK.framework'  
end