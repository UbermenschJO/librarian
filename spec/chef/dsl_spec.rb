require 'librarian'
require 'librarian/chef'

module Librarian
  module Chef

    describe Dsl do

      context "simple" do

        it "should run with a source given as hash options on a dependency" do
          deps = Dsl.run do
            cookbook 'apt',
              :git => 'https://github.com/opscode/cookbooks.git'
          end.dependencies
          deps.should_not be_empty
          deps.first.name.should == 'apt'
          deps.first.source.uri.should =~ /opscode\/cookbooks/
        end

        it "should run with a hash block source" do
          deps = Dsl.run do
            source :git => 'https://github.com/opscode/cookbooks.git' do
              cookbook 'apt'
            end
          end.dependencies
          deps.should_not be_empty
          deps.first.name.should == 'apt'
          deps.first.source.uri.should =~ /opscode\/cookbooks/
        end

        it "should run with a named block source" do
          deps = Dsl.run do
            git 'https://github.com/opscode/cookbooks.git' do
              cookbook 'apt'
            end
          end.dependencies
          deps.should_not be_empty
          deps.first.name.should == 'apt'
          deps.first.source.uri.should =~ /opscode\/cookbooks/
        end

        it "should run with a default source" do
          deps = Dsl.run do
            git 'https://github.com/opscode/cookbooks.git'
            cookbook 'apt'
          end.dependencies
          deps.should_not be_empty
          deps.first.name.should == 'apt'
          deps.first.source.uri.should =~ /opscode\/cookbooks/
        end

      end

    end

  end
end