# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'CodeChallange' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire', '5.4.1'
  pod 'SVProgressHUD'
  pod 'ESPullToRefresh'

  target 'CodeChallangeTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'CodeChallangeUITests' do
    # Pods for testing
  end

end
#To set all the pods to minimum deployment target : 11.0, if any has set to lower then that.
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 11.0
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = 11.0
      end
    end
  end
end
