@version = "1.1.1"

Pod::Spec.new do |s|
  s.name         = "TableViewPager"
  s.version      = @version
  s.summary      = "A simple 'Table View Pager' for iOS which is inspired by Android's view pager."

  s.description  = <<-DESC
                   A simple 'Table View Pager' for iOS which is inspired by Android's view pager. It is useful for applications having requirement of multiple table views which requires switching with the help of different tabs in one ViewController.
                   DESC

  s.homepage     = "https://github.com/SandeepAggarwal/Table-View-Pager"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  s.author             = { "Sandeep Aggarwal" => "smartsandeep1129@gmail.com" }
  s.social_media_url   = "https://twitter.com/sandeepCool77"
  s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/SandeepAggarwal/Table-View-Pager.git", :tag => "#{s.version}" }
  s.source_files  = "ViewPager"
s.requires_arc = true
end
