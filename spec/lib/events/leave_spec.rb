require "spec_helper"

describe Pubnub::Leave do
  it_behaves_like "an event"

  context "given basic parameters" do
    before :each do
      @pubnub = Pubnub::Client.new(
        subscribe_key: "sub-a-mock-key",
        publish_key: "pub-a-mock-key",
        auth_key: "ruby-test-auth",
        uuid: "ruby-test-uuid",
      )
    end

    it "works" do
      VCR.use_cassette("lib/events/leave", record: :once) do
        envelope = @pubnub.leave(
          channel: :demo,
        ).value

        expect(envelope.status).to satisfies_schema Pubnub::Schemas::Envelope::StatusSchema
      end
    end

    it "forms valid ErrorEnvelope on error" do
      VCR.use_cassette("lib/events/leave-error", record: :once) do
        envelope = @pubnub.leave(
          channel: :demo,
        ).value

        expect(envelope.is_a?(Pubnub::ErrorEnvelope)).to eq true
        expect(envelope.status).to satisfies_schema Pubnub::Schemas::Envelope::StatusSchema
      end
    end
  end
end
