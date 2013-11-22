require 'spec_helper'

describe Catscan do

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

  let(:subject) { Patient.new }

  it "should respond to #scan" do
    expect(subject.respond_to? :scan).to be
  end

  it "should respond to ::scan" do
    expect(Patient.respond_to? :scan).to be
  end


  context "when extended to scan within an instance or class method" do

    it "should " do
      Patient.class_eval do
        def instance_scan
          scan self do
            name
          end
        end
      end

      expect(subject.instance_scan).to eq("Batman")
    end

    it "should " do
      Patient.class_eval do
        class << self

          def class_scan
            scan self do
              real_name
            end
          end

        end
      end

      expect(Patient.class_scan).to eq("Bruce Wayne")
    end

  end

  context "when an exception is raised" do

    it "should " do
      Patient.class_eval do
        def instance_scan
          scan self do
            raise StandardError
          end
        end
      end

      subject.expects(:puts).with "Logging Error!"
      subject.instance_scan
    end

  end

end
