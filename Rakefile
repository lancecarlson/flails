CURRENT_DIR = File.dirname(__FILE__)
RAILS_DIR = File.join(CURRENT_DIR, "rails")
SWC_DIR = File.join(CURRENT_DIR, "swc")

namespace :rails do
  desc "Start the test rails application"
  task :start do
    unless File.file?("rails/log/mongrel.pid")
      Dir.chdir "rails" do
        system("mongrel_rails start -d")
      end
    end
  end

  desc "Stop the test rails application"
  task :stop do
    if File.file?("rails/log/mongrel.pid")
      Dir.chdir "rails" do
        system("mongrel_rails stop")
      end
    end
  end
end

namespace :compile do
  desc "Compile component"
  task :component do
    system("compc -load-config=#{CURRENT_DIR}/build_swc.xml")
  end
  
  desc "Compile tests"
  task :tests do
    cmd = "mxmlc"
    cmd << " -source-path #{CURRENT_DIR}/src"
    cmd << " -output #{RAILS_DIR}/public/test/results.swf"
    cmd << " -library-path+=#{SWC_DIR}"
    cmd << " -- #{CURRENT_DIR}/Test.mxml"
    
    system(cmd)
  end
end

desc "Build swc file"
task :build => 'compile:component'

desc "Run tests"
task :test => ['rails:start', 'compile:tests'] do
  system("open http://localhost:3000/test/results.swf")
end
