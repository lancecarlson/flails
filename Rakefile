CURRENT_DIR = File.dirname(__FILE__)
RAILS_DIR = File.join(CURRENT_DIR, "rails")
SWC_DIR = File.join(CURRENT_DIR, "swc")

desc "Build swc file"
task :build do
  cmd = "compc -load-config=build-swc.xml"
  puts `#{cmd}`
end

desc "Test"
task :test do
  cmd = "mxmlc"
  cmd << " -output #{RAILS_DIR}/public/test/results.swf"
  cmd << " -library-path+=#{SWC_DIR}"
  cmd << " -- #{CURRENT_DIR}/Test.mxml"
    
  puts `#{cmd}`
  system("open", "http://localhost:3000/test/results.swf")
end