use_frameworks!
inhibit_all_warnings!
platform :ios, '10.0'

#open source
source 'https://github.com/CocoaPods/Specs.git'

target 'EEETravel' do

#    pod 'IQKeyboardManager'                                     , '4.0.3'
#    pod 'JSPatch'                                               , '1.0'

#    pod 'UMengAnalytics'                                        , '4.1.0'
#    pod 'SwiftyJSON'                                            , '2.4.0'
    pod 'SnapKit'                                               ,'~> 3.0.2'
    pod 'PullToMakeSoup'                                        ,'~> 2.0'
    pod 'Kingfisher'                                            ,‘3.2.1’

    
    pod 'ShareSDK3'                                             , '3.5.0'
    pod 'MOBFoundation'                                         , '2.2.1'
    pod 'ShareSDK3/ShareSDKExtension'
    pod 'ShareSDK3/ShareSDKPlatforms/QQ'
    pod 'ShareSDK3/ShareSDKPlatforms/SinaWeibo'
    pod 'ShareSDK3/ShareSDKPlatforms/WeChat'
    
end



post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|

            # 指定使用swift 2.3版本   
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
