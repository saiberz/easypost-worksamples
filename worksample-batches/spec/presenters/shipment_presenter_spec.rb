require 'spec_helper'

describe ShipmentPresenter do
  let(:shipment) { FactoryGirl.build :shipment }

  describe "#to_json" do
    subject { described_class.new(shipment).as_json }

    its([:object]) { is_expected.to eq('Shipment') }
    its([:id]) { is_expected.to match(/^shp_/) }
    its([:mode]) { is_expected.to eq(EasyPost::ApiMode::TEST) }

    it 'includes many helpful shipment fields' do
      is_expected.to include(
        :object,
        :id,
        :mode,
        :messages,
        :reference,
        :from_address,
        :to_address,
        :parcel,
        :rates,
        :selected_rate,
        :postage_label,
        :tracking_code,
        :created_at,
        :updated_at
      )
    end
  end
end


