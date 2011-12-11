require 'XCodeDeployer'
require 'XCodeProduct'

name = "MediaManagement"
silenceBuilds = true
products = [ XCodeProduct.new(name, "#{name}-iPhone", "Debug", ["iphoneos", "iphonesimulator"]),
			XCodeProduct.new(name, "#{name}-x86", "Debug", ["macosx"])]
			
#			{"name" => "#{name}-iPhone", "configuration" => "Release", "sdks" => ["iphoneos", "iphonesimulator"]},
#			{"name" => "#{name}-MacOSX", "configuration" => "Release", "sdks" => ["macosx"]}
#			]
builder = XCodeDeployer.new(products, false)

task :setup do
	builder.setup
end

task :default => [:build, :deploy] do
end

task :clean do
	puts "cleaning " + name
	builder.clean
end

task :build do
	puts "building " + name
	builder.build
end

task :deploy do
	puts "Deploying " + name
	builder.deploy
end

task :release => [:setup, :clean, :build, :deploy] do
	builder.release
end

