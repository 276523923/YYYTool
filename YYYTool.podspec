Pod::Spec.new do |s|

  s.name         = "YYYTool"
  s.version      = "0.0.4"
  s.summary      = "YYYTool"

  s.description  = <<-DESC
YYYTool 常用工具
                   DESC

  s.homepage     = "https://github.com/276523923/YYYTool.git"

  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { "yyy" => "276523923@qq.com" }

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.source       = { :git => "https://github.com/276523923/YYYTool.git", :tag => s.version.to_s }
  s.source_files  = "Category/**/*.{m,h}","Helper/**/*.{m,h}"

  s.requires_arc = true

end