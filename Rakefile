CURRENT_DIR = File.dirname(__FILE__)
RAILS_DIR = File.join(CURRENT_DIR, "rails")
TEST_SWF = "#{RAILS_DIR}/public/test/results.swf"
SWC_DIR = File.join(CURRENT_DIR, "swc")

namespace :rails do
  desc "Start the test rails application"
  task :start do
    unless File.file?("rails/log/mongrel.pid")
      Dir.chdir "rails" do
        sh "mongrel_rails start -d"
      end
    end
  end

  desc "Stop the test rails application"
  task :stop do
    if File.file?("rails/log/mongrel.pid")
      Dir.chdir "rails" do
        sh "mongrel_rails stop"
      end
    end
  end
end

namespace :compile do
  desc "Compile component"
  task :component do
    sh "compc -load-config+=build_swc.xml \
              -include-namespaces=\"http://github.com/lancecarlson/flails\" \
              -namespace \"http://github.com/lancecarlson/flails\" manifest.xml"
  end
  
  desc "Compile tests"
  task :tests do
    cmd = "mxmlc"
    cmd << " -debug=true"
    cmd << " -source-path #{CURRENT_DIR}/src"
    cmd << " -output #{TEST_SWF}"
    cmd << " -library-path+=#{SWC_DIR}"
    cmd << " -- #{CURRENT_DIR}/Test.mxml"
    
    sh cmd
  end
end


desc "Delete artifacts"
task :clean do
  FileUtils.rm_rf('pkg')
  FileUtils.rm_f(TEST_SWF)
end


desc "Build swc file"
task :build => 'compile:component'

namespace :test do
  desc "Run tests and view results"
  task :open => :test do
    sh "open http://localhost:3000/test/results.swf"
  end
end       

desc "Run tests"
task :test => ['rails:start', 'compile:tests']
