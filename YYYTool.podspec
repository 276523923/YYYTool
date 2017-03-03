Pod::Spec.new do |s|

  s.name         = "YYYTool"
  s.version      = "0.0.5"
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
  s.default_subspec = 'All'

  s.subspec 'All' do |ss|
    ss.dependency 'Helper'
    ss.dependency 'Category'
  end

  s.subspec 'Helper' do |ss|
    s.source_files  = "Helper/**/*.{m,h}"
  end

  s.subspec 'Category' do |ss|
    s.source_files  = "Category/**/*.{m,h}"
  end

end