module Machinist
  module ActiveRecord
    class Blueprint < Machinist::Blueprint
      # Make and save an object.
      def make!(attributes = {})
        object = make(attributes)
        object.save!
        object.reload
      rescue ::ActiveRecord::RecordInvalid => exception
        message = "#{exception.class.name}: \"#{exception.message}\" saving #{exception.record.class.name}"
        raise Machinist::BlueprintCantSaveError.new(self, message)
      end

      def lathe_class #:nodoc:
        Machinist::ActiveRecord::Lathe
      end
    end
  end
end
