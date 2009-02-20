CURRENT_DIR = File.dirname(__FILE__)
RAILS_DIR = File.join(CURRENT_DIR, "rails")
SWC_DIR = File.join(CURRENT_DIR, "swc")

desc "Build swc file"
task :build do
  cmd = "compc -load-config=#{CURRENT_DIR}/build_swc.xml"
  puts `#{cmd}`
end

desc "Test"
task :test do
  cmd = "mxmlc"
  cmd << " -source-path #{CURRENT_DIR}/src"
  cmd << " -output #{RAILS_DIR}/public/test/results.swf"
  cmd << " -library-path+=#{SWC_DIR}"
  cmd << " -- #{CURRENT_DIR}/Test.mxml"
    
  puts `#{cmd}`
  `open http://localhost:3000/test/results.swf`
end