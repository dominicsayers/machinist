RSpec.describe Machinist, 'exceptions' do
  describe Machinist::BlueprintCantSaveError do
    it 'presents the right message' do
      blueprint = Machinist::Blueprint.new(String) {}
      exception = Machinist::BlueprintCantSaveError.new(blueprint)
      expect(exception.message).to eq('make! is not supported by blueprints for class String')
    end
  end

  describe Machinist::NoBlueprintError do
    it 'presents the right message' do
      exception = Machinist::NoBlueprintError.new(String, :master)
      expect(exception.message).to eq('No master blueprint defined for class String')
    end
  end
end
