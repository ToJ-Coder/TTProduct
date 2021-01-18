# Uncomment the next line to define a global platform for your project
# platform :ios, '10.00'
# platform :MAC, '10.12'

# Comment the next line if you don't want to use dynamic frameworks

workspace 'TT.xcworkspace'

def networking_pods
  pod 'AFNetworking'
  pod 'Alamofire'
end


def json_pods
  pod 'KakaJSON'
  pod 'HandyJSON'
end


def common_pods
   pod 'SnapKit'
end


target 'TTNetwork-iOS' do
  use_frameworks!
  
  project 'TTNetwork/TTNetwork.xcodeproj'
  
  networking_pods
  json_pods
end

target 'TTNetwork-Mac' do
  use_frameworks!
  
  project 'TTNetwork/TTNetwork.xcodeproj'
  
  networking_pods
  json_pods
end

target 'TTCoreData-iOS' do
  use_frameworks!

  project 'TTCoreData/TTCoreData.xcodeproj'
  
  json_pods
end

target 'TTCoreData-Mac' do
  use_frameworks!

  project 'TTCoreData/TTCoreData.xcodeproj'
  
  json_pods
end

# 项目引用
# TTProduct-iPad
target 'TTProduct-iPad' do
  use_frameworks!

  project 'TTProduct-iPad/TTProduct-iPad.xcodeproj'
  
  common_pods
end

# 项目引用
# TTProduct-macOS
target 'TTProduct-macOS' do
  use_frameworks!

  project 'TTProduct-macOS/TTProduct-macOS.xcodeproj'
  
  common_pods
end
