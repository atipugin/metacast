require 'rails_helper'

module Episodes
  RSpec.describe ProcessEpisode do
    subject(:service) do
      described_class.new(episode: episode, audio_path: audio_path)
    end

    let(:episode) { build(:episode) }
    let(:audio_path) do
      Rails.root.join('spec', 'support', 'uploads', 'audio.mp3')
    end
    let(:youtube_dl_double) { instance_double(YoutubeDl) }
    let(:image_url) { FFaker::Internet.http_url }
    let(:title) { FFaker::Lorem.word }
    let(:description) { FFaker::Lorem.paragraph }

    # TODO: Move YoutubeDl stubs to shared context
    before do
      allow(YoutubeDl).to receive(:new).and_return(youtube_dl_double)
      allow(youtube_dl_double).to receive(:run!)
      allow(youtube_dl_double).to receive(:image_url).and_return(image_url)
      allow(youtube_dl_double).to receive(:title).and_return(title)
      allow(youtube_dl_double).to receive(:description).and_return(description)

      stub_request(:get, image_url).to_return(
        body: Rails.root.join('spec', 'support', 'uploads', 'image.png').open
      )
    end

    describe 'validations' do
      it { is_expected.to be_valid }
    end

    describe '#perform' do
      it 'processes the episode' do
        expect { service.perform }.to change(episode, :state).to('processed')
      end

      it 'assigns audio' do
        expect { service.perform }.to change(episode, :audio_url)
      end

      it 'assigns image' do
        expect { service.perform }.to change(episode, :image_url)
      end

      it 'assigns title' do
        expect { service.perform }.to change(episode, :title)
      end

      it 'assigns description' do
        expect { service.perform }.to change(episode, :title)
      end

      context 'when there is not audio' do
        let(:audio_path) { nil }

        it 'fails the episode' do
          expect { service.perform }.to change(episode, :state).to('failed')
        end

        it 'does not assign audio' do
          expect { service.perform }.not_to change(episode, :audio_url)
        end
      end
    end
  end
end
