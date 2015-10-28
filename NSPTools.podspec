Pod::Spec.new do |s|
  s.name         = 'NSPTools'
  s.version      = '0.0.1'
  s.summary      = 'test pod.'
  s.homepage     = 'https://github.com/bigtreenono/NSPTools'
  s.author       = { 'bigtreenono' => '451805261@qq.com' }
  s.platform     = :ios, "7.0"
  s.license      = 'MIT'
  s.source       = { :git => 'https://github.com/bigtreenono/NSPTools.git', :tag => s.version}
  s.source_files = 'NSPTools'
  s.requires_arc = true
end
