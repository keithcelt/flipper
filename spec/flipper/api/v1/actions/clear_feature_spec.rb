require 'helper'

RSpec.describe Flipper::Api::V1::Actions::ClearFeature do
  let(:app) { build_api(flipper) }

  describe 'clear' do
    before do
      Flipper.register(:admins) {}
      actor_class = Struct.new(:flipper_id)
      actor22 = actor_class.new('22')

      feature = flipper[:my_feature]
      feature.enable flipper.boolean
      feature.enable flipper.group(:admins)
      feature.enable flipper.actor(actor22)
      feature.enable flipper.actors(25)
      feature.enable flipper.time(45)

      delete '/features/my_feature/clear'
    end

    it 'clears feature' do
      expect(last_response.status).to eq(204)
      expect(flipper[:my_feature].off?).to be_truthy
    end
  end
end