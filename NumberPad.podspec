Pod::Spec.new do |s|
  s.name                  = "NumberPad"
  s.version               = "0.0.1"
  s.summary               = "NumberPad UI"
  s.homepage              = "https://github.com/neo1125/NumberPad"
  s.screenshots           = "https://github.com/neo1125/NumberPad/blob/master/images/01.png?raw=true", 
                            "https://github.com/neo1125/NumberPad/blob/master/images/02.png?raw=true",
                            "https://github.com/neo1125/NumberPad/blob/master/images/03.png?raw=true"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "HunHee Yoon" => "yhh1125@gmail.com" }
  s.ios.deployment_target = "9.0"
  s.source                = { :git => "https://github.com/neo1125/NumberPad", :tag => s.version.to_s }
  s.source_files          = "NumberPad/Sources/*.swift"
  s.resources             = "NumberPad/Resources/*.xcassets"
end
