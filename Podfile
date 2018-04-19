# Uncomment the next line to define a global platform for your project
# platform :ios, '11.0'

target 'DemoKKBOXOpenAPI' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  platform :ios, '11.0'

  pod 'KKBOXOpenAPISwift',
  :git => 'https://github.com/KKBOX/OpenAPI-Swift.git',
  :branch => 'master'

  target 'DemoKKBOXOpenAPITests' do
    pod 'KKBOXOpenAPISwift',
    :git => 'https://github.com/KKBOX/OpenAPI-Swift.git',
    :branch => 'master'
    # Pods for testing
  end

  target 'DemoKKBOXOpenAPIUITests' do
    inherit! :search_paths
    # Pods for testing
  end
end
