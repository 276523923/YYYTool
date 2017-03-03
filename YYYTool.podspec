Pod::Spec.new do |s|

  s.name         = "YYYTool"
  s.version      = "0.0.6"
  s.summary      = "YYYTool"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/276523923/YYYTool.git"
  s.author             = { "yyy" => "276523923@qq.com" }

  s.description  = <<-DESC
YYYTool 常用工具
                   DESC

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/276523923/YYYTool.git", :tag => s.version.to_s }
  s.requires_arc = true


  s.subspec 'Helper' do |helper|
    helper.source_files  = "YYYTool/Helper/**/*.{m,h}"
    helper.public_header_files = "YYYTool/Helper/**/*.{h}"
  end

  s.subspec 'Category' do |category|
    category.dependency 'YYYTool/Helper'
    category.public_header_files = "YYYTool/Category/**/*.{h}"
    category.source_files  ="YYYTool/Category/**/*.{m,h}"
  end

end