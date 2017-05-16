require 'ostruct'

module InheritanceSpecs
  class Grandpa
    extend Machinist::Machinable
    attr_accessor :name, :age
  end

  class Dad < Grandpa
    extend Machinist::Machinable
    attr_accessor :name, :age
  end

  class Son < Dad
    extend Machinist::Machinable
    attr_accessor :name, :age
  end
end

RSpec.describe Machinist::Blueprint do
  describe 'explicit inheritance' do
    it 'inherits attributes from the parent blueprint' do
      parent_blueprint = described_class.new(OpenStruct) do
        name { 'Fred' }
        age  { 97 }
      end

      child_blueprint = described_class.new(OpenStruct, parent: parent_blueprint) do
        name { 'Bill' }
      end

      child = child_blueprint.make
      expect(child.name).to eq('Bill')
      expect(child.age).to eq(97)
    end

    it 'takes the serial number from the parent' do
      parent_blueprint = described_class.new(OpenStruct) do
        parent_serial { sn }
      end

      child_blueprint = described_class.new(OpenStruct, parent: parent_blueprint) do
        child_serial { sn }
      end

      expect(parent_blueprint.make.parent_serial).to eq('0001')
      expect(child_blueprint.make.child_serial).to eq('0002')
      expect(parent_blueprint.make.parent_serial).to eq('0003')
    end
  end

  describe 'class inheritance' do
    before do
      [InheritanceSpecs::Grandpa, InheritanceSpecs::Dad, InheritanceSpecs::Son].each(&:clear_blueprints!)
    end

    it 'inherits blueprinted attributes from the parent class' do
      InheritanceSpecs::Dad.blueprint do
        name { 'Fred' }
      end
      InheritanceSpecs::Son.blueprint {}
      expect(InheritanceSpecs::Son.make.name).to eq('Fred')
    end

    it 'overrides blueprinted attributes in the child class' do
      InheritanceSpecs::Dad.blueprint do
        name { 'Fred' }
      end
      InheritanceSpecs::Son.blueprint do
        name { 'George' }
      end
      expect(InheritanceSpecs::Dad.make.name).to eq('Fred')
      expect(InheritanceSpecs::Son.make.name).to eq('George')
    end

    it 'inherits from blueprinted attributes in ancestor class' do
      InheritanceSpecs::Grandpa.blueprint do
        name { 'Fred' }
      end
      InheritanceSpecs::Son.blueprint {}
      expect(InheritanceSpecs::Grandpa.make.name).to eq('Fred')
      expect { InheritanceSpecs::Dad.make }.to raise_error(RuntimeError)
      expect(InheritanceSpecs::Son.make.name).to eq('Fred')
    end

    it 'follows inheritance for named blueprints correctly' do
      InheritanceSpecs::Dad.blueprint do
        name { 'John' }
        age  { 56 }
      end
      InheritanceSpecs::Dad.blueprint(:special) do
        name { 'Paul' }
      end
      InheritanceSpecs::Son.blueprint(:special) do
        age { 37 }
      end
      expect(InheritanceSpecs::Son.make(:special).name).to eq('John')
      expect(InheritanceSpecs::Son.make(:special).age).to eq(37)
    end
  end
end
