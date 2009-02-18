CURRENT_DIR = File.dirname(__FILE__)
FLEXUNIT_PATH = File.join(CURRENT_DIR, "test/FlexUnit.swc")
RAILS_DIR = File.join(CURRENT_DIR, "rails")

desc "Test"
task :test do
  puts `mxmlc -use-network=false #{CURRENT_DIR}/Test.mxml -output #{RAILS_DIR}/public/test/results.swf -library-path+=#{FLEXUNIT_PATH}`
  system("open", "http://localhost:3000/test/results.swf")
end