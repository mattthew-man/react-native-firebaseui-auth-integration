
Pod::Spec.new do |s|
  s.name         = "RNFirebaseuiAuth"
  s.version      = "1.0.0"
  s.summary      = "RNFirebaseuiAuth"
  s.description  = <<-DESC
                  RNFirebaseuiAuth
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }
  s.author             = "Maintainers"
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/your-org/react-native-firebaseui-auth.git", :tag => s.version.to_s }
  s.source_files  = "RNFirebaseuiAuth/**/*.{h,m}"
  s.requires_arc = true


  s.dependency "React"
  #s.dependency "others"

end

  