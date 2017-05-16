require 'ostruct'

RSpec.describe Machinist::Blueprint do
  it 'makes an object of the given class' do
    blueprint = described_class.new(OpenStruct) {}
    expect(blueprint.make).to be_an(OpenStruct)
  end

  it 'constructs an attribute from the blueprint' do
    blueprint = described_class.new(OpenStruct) do
      name { 'Fred' }
    end
    expect(blueprint.make.name).to eq('Fred')
  end

  it 'constructs an array for an attribute in the blueprint' do
    blueprint = described_class.new(OpenStruct) do
      things(3) { Object.new }
    end
    things = blueprint.make.things
    expect(things).to be_an(Array)
    expect(things.size).to eq(3)
    things.each { |thing| expect(thing).to be_an(Object) }
    expect(things.uniq).to eq(things)
  end

  it 'allows passing in attributes to override the blueprint' do
    block_called = false
    blueprint = described_class.new(OpenStruct) do
      name do
        block_called = true
        'Fred'
      end
    end
    expect(blueprint.make(name: 'Bill').name).to eq('Bill')
    expect(block_called).to be_falsey
  end

  it 'provides a serial number within the blueprint' do
    blueprint = described_class.new(OpenStruct) do
      name { "Fred #{sn}" }
    end
    expect(blueprint.make.name).to eq('Fred 0001')
    expect(blueprint.make.name).to eq('Fred 0002')
  end

  it 'provides access to the object being constructed within the blueprint' do
    blueprint = described_class.new(OpenStruct) do
      title { 'Test' }
      body  { object.title }
    end
    expect(blueprint.make.body).to eq('Test')
  end

  it 'allows attribute names to be strings' do
    blueprint = described_class.new(OpenStruct) do
      name { 'Fred' }
    end
    expect(blueprint.make('name' => 'Bill').name).to eq('Bill')
  end

  # These are normally a problem because of name clashes with the standard (but
  # deprecated) Ruby methods. This test makes sure we work around this.
  it 'works with type and id attributes' do
    klass = Class.new do
      attr_accessor :id, :type
    end
    blueprint = described_class.new(klass) do
      id   { 'custom id' }
      type { 'custom type' }
    end
    object = blueprint.make
    expect(object.id).to eq('custom id')
    expect(object.type).to eq('custom type')
  end
end
