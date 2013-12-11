require 'spec_helper'

module Catscan
  describe Scannable do

    class Patient
      include Catscan::Scannable

      @real_name = "Bruce Wayne"

      def initialize
        @name = "Batman"
      end

      attr_reader :name

      class << self
        attr_accessor :real_name
      end

    end

    let(:subject) { Patient }

    it "should respond to ::scan" do
      expect(subject.respond_to? :scan).to be
    end

    context "when scanning within an instance or class method" do

      it "should return the value of the block passed to ::scan" do
        Patient.class_eval do
          def instance_scan
            self.class.scan self do
              name
            end
          end
        end

        expect(subject.new.instance_scan).to eq("Batman")
      end

      it "should return the value of the block passed to ::scan" do
        Patient.class_eval do
          class << self

            def class_scan
              scan self do
                real_name
              end
            end

          end
        end

        expect(subject.class_scan).to eq("Bruce Wayne")
      end

    end

    context "when an exception is raised within the block passed to ::scan" do

      it "should raise the exception" do
        Patient.class_eval do
          def instance_scan
            self.class.scan self do
              raise StandardError
            end
          end
        end

        subject.expects(:puts).with "Error!"
        expect {subject.new.instance_scan}.to raise_error(StandardError)
      end

      it "should raise the exception" do
        Patient.class_eval do
          class << self
            def class_scan
              scan self do
                raise StandardError
              end
            end
          end
        end

        subject.expects(:puts).with "Error!"
        expect {subject.class_scan}.to raise_error(StandardError)
      end
    end

    context "when included into a module" do
      it "should respond to `:scan` as a class method" do
        module M
          include Catscan::Scannable
        end

        expect(M.respond_to? :scan).to be
      end
    end

  end
end
