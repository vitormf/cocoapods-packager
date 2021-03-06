require File.expand_path('../../spec_helper', __FILE__)

module Pod
  describe Command::Package do
    it "uses additional spec repos passed on the command line" do
      SourcesManager.stubs(:search).returns(nil)
      nil::NilClass.any_instance.stubs(:install!)
      Installer.expects(:new).with { 
          |sandbox, podfile| podfile.sources == ['foo', 'bar'] 
        }

      command = Command.parse(%w{ package spec/fixtures/KFData.podspec --spec-sources=foo,bar})
      command.send(:install_pod, :osx)
    end

    it "uses only the master repo if no spec repos were passed" do
      SourcesManager.stubs(:search).returns(nil)
      nil::NilClass.any_instance.stubs(:install!)
      Installer.expects(:new).with { 
          |sandbox, podfile| podfile.sources == ['https://github.com/CocoaPods/Specs.git'] 
        }

      command = Command.parse(%w{ package spec/fixtures/KFData.podspec })
      command.send(:install_pod, :osx)
    end
  end
end
