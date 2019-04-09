require 'rails_helper'

module Episodes
  RSpec.describe ProcessEpisode do
    subject(:service) do
      described_class.new(episode: episode)
    end

    let(:episode) { build(:episode) }
    let(:youtube_dl_double) { instance_double(YoutubeDl) }
    let(:output) { Rails.root.join('tmp', 'audio.mp3') }
    let(:image_url) { FFaker::Internet.http_url }
    let(:title) { FFaker::Lorem.word }
    let(:description) { FFaker::Lorem.paragraph }
    let(:author) { FFaker::Name.name }

    # TODO: Move YoutubeDl stubs to shared context
    before do
      allow(YoutubeDl).to receive(:new).and_return(youtube_dl_double)
      allow(youtube_dl_double).to receive(:run!)
      allow(youtube_dl_double).to receive(:output).and_return(output)
      allow(youtube_dl_double).to receive(:image_url).and_return(image_url)
      allow(youtube_dl_double).to receive(:title).and_return(title)
      allow(youtube_dl_double).to receive(:description).and_return(description)
      allow(youtube_dl_double).to receive(:author).and_return(author)

      FileUtils.cp(
        Rails.root.join('spec', 'support', 'uploads', 'audio.mp3'),
        output
      )

      stub_request(:get, image_url).to_return(
        body: Rails.root.join('spec', 'support', 'uploads', 'image.png').open
      )
    end

    describe 'validations' do
      it { is_expected.to be_valid }
    end

    describe 'callbacks' do
      it 'removes audio file' do
        expect { service.run }.to change { File.exist?(output) }.to(false)
      end
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
        expect { service.perform }.to change(episode, :description)
      end

      it 'assigns author' do
        expect { service.perform }.to change(episode, :author)
      end

      context 'when there is not audio' do
        before do
          FileUtils.rm(output)
        end

        it 'fails the episode' do
          expect { service.perform }.to change(episode, :state).to('failed')
        end
      end
    end
  end
end
