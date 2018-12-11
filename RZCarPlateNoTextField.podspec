Pod::Spec.new do |s|


  s.name         = "RZCarPlateNoTextField"
  s.version      = "0.0.1"
  s.summary      = "RZCarPlateNoTextField车牌号键盘"

  s.description  = <<-DESC
                      车牌号键盘
                   DESC
  s.homepage     = "https://github.com/rztime/RZCarPlateNoTextField"

  s.license      = { :type => "MIT", :file => "LICENSE" }

  s.author             = { "rztime" => "rztime@vip.qq.com" }

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/rztime/RZCarPlateNoTextField.git", :tag => "#{s.version}" }


  s.source_files  = "Core", "RZCarPlateNoTextField/Core/*.{h,m}"

  s.subspec 'KeyBoard' do |ss|
    ss.source_files = "RZCarPlateNoTextField/Core/KeyBoard/**/*.{h,m}"
    end
  s.resources = "RZCarPlateNoTextField/Core/KeyBoard/**/*.{bundle}"


end
