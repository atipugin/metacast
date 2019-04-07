require 'rails_helper'

module Episodes
  RSpec.describe ProcessEpisode do
    subject(:service) { described_class.new(episode: episode) }

    let(:episode) { build(:episode) }

    describe 'validations' do
      it { is_expected.to be_valid }
    end

    describe '#perform' do
      it 'processes the episode' do
        expect { service.perform }.to change(episode, :state).to('processed')
      end
    end
  end
end
