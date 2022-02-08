# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'showapp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for showapp

pod 'FBSDKLoginKit'
pod 'GoogleSignIn'
pod 'DropDown'
pod 'GoogleMaps'
pod 'GooglePlaces'
pod 'PayPalCheckout'
pod 'SendBirdUIKit'
pod 'ViewAnimator'
pod 'AppCenter'
pod 'Braintree'
pod 'MessageKit'

  target 'showappTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'showappUITests' do
    # Pods for testing
  end
post_install do |installer|
     installer.pods_project.targets.each do |target|
         target.build_configurations.each do |config|
            if config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'].to_f < 12.0
              config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
            end
         end
     end
  end

end
