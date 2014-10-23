Pod::Spec.new do |spec|
  spec.name = 'AHCodesignValidator'
  spec.version = '0.1'
  spec.platform = :osx
  spec.license = 'MIT'
  spec.summary = 'A simple Objective-c class for testing/comparing codesign of an item(s).'
  spec.homepage = 'https://github.com/eahrold/AHCodesignValidator'
  spec.authors  = { 'Eldon Ahrold' => 'eldon.ahrold@gmail.com' }
  spec.source   = { :git => 'https://github.com/eahrold/AHCodesignValidator.git', :tag => "v#{spec.version}" }
  spec.requires_arc = true
  spec.public_header_files = 'AHCodesignValidator/*.h'
  spec.source_files = 'AHCodesignValidator/*.{h,m}'
end
