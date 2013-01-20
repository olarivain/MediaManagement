require 'FileUtils'

# attempt to load custom paths for our libraries
custom_path = "./DevPaths.rb"
if File.exists? custom_path then
	custom_paths = eval(File.new(custom_path).read)
	puts "Using custom paths for OpenTable libraries from #{custom_path}."
else 
	custom_paths = Hash.new
	puts "Released version of OpenTable libraries will be used. If you wish to use local version, create DevPaths.rb, see DevPaths-sample.rb for an example"

end
puts

platform :osx, "10.7"

# loads local dev version of a pod if found, failing back to released version otherwise
def dev_pod_or_released(name, version, dev_path)
	if dev_path != nil && (File.exists? File.expand_path(dev_path)) then
		pod name, :local => dev_path
		puts "Using #{name} located at #{dev_path}"
	else
		pod name, "~> #{version}"
		puts "Using latest released version of #{name}"
	end
end

dev_pod_or_released("KraCommons", "0.0.1", custom_paths[:KraCommons])
puts

target :MMCx86 do
	platform :osx, "10.7"
end

target :MMCarm do
	platform :ios, "5.0"
end