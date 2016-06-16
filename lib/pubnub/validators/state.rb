# Toplevel Pubnub module.
module Pubnub
  # Validator module that holds all validators modules
  module Validator
    # Validator for State event
    module State
      include CommonValidator

      def validate!
        return if @skip_validate
        validate_channel_and_uuid!
      end

      private

      def validate_channel_and_uuid!
        fail(
          ArgumentError.new(
            object: self,
            message: 'You have to specify :channel or :uuid for State event.'
          ),
          'You have to specify :channel or :uuid for State event.'
        ) if @channel.size == 0 && @uuid_looking_for.nil?
      end
    end
  end
end
