Pod::Spec.new do |s|

  s.name         = "YYYTool"
  s.version      = "1.0.8"
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

    category.subspec 'Foundation' do|fo|
      fo.dependency 'YYYTool/Helper'
      fo.public_header_files = "YYYTool/Category/Foundation/*.{h}"
      fo.source_files  ="YYYTool/Category/Foundation/*.{m,h}"
    end

    category.subspec 'UIKit' do|kit|
      kit.dependency 'YYYTool/Helper'
      kit.dependency 'YYYTool/Category/Foundation'
      kit.public_header_files = "YYYTool/Category/UIKit/*.{h}"
      kit.source_files  ="YYYTool/Category/UIKit/*.{m,h}"
    end

  end

end
