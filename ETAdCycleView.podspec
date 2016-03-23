Pod::Spec.new do |s|
  s.name         = "ETAdCycleView"
  s.version      = "1.0.0"
  s.summary             = "ETAdCycleView is an auto cycle or loop UIScrollview for horizonal advertisement or banner."

  s.homepage     = "https://github.com/VolleyZ/ETAdCycleView"
  s.license     = { :type => "MIT", :file => "LICENSE" }

  s.author       = { "VolleyZ" => "VolleyZhang@hotmail.com" }
  s.source       = { :git => "https://github.com/VolleyZ/ETAdCycleView.git", :tag => s.version.to_s }

  s.source_files  = "ETAdCycleView/Class/**/*.{swift}"
  s.dependency 'Kingfisher', '~> 2.1'
  s.platform            = :ios, '8.0'
end