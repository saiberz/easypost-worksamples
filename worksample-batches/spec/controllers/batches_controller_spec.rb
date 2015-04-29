require 'spec_helper'

describe BatchesController do
  let(:user) { FactoryGirl.create(:user) }
  let(:batch) { FactoryGirl.create(:batch, user: user) }

  describe '#buy' do
    specify do
      api_post user, :buy, {"id" => batch.public_id} # helper in spec/support/
                                                     # controller_example_group.rb
      expect(response.status).to eq(200)
    end
  end

end
