# This is Git's per-user configuration file.
Pod::Spec.new do |s|
  s.name         = "HShakeAlertView"
  s.version      = "1.0.0"
  s.summary      = "使用场景：给定一个密码，弹出输入框，用给定的密码进行验证，如密码不正确，则不取消alertview，并做错误提示。正确则在block里执行下一步"
  s.homepage     = "https://github.com/vivihu/HShakeAlertView"
  s.license      = "MIT"
  s.authors = { '胡伟伟' => 'huweiwei1991@gmail.com' }
  s.platform     = :ios, "5.0"
  s.source       = { :git => "https://github.com/vivihu/HShakeAlertView.git", :tag => s.version }
  s.source_files = 'HShakeAlertView/**/*.{h,m}'
  s.requires_arc = true
end

