require 'rails_helper'

RSpec.describe Gemfile, type: :model do
  let(:gemfile) { Gemfile.new({ gemfile: "gem 'rails'" }) }

  describe '#initialize', :vcr do
    %w(gemfile gems updated_gemfile).each do |attr| 
      it "assigns #{attr}" do
        expect(gemfile).to respond_to(attr.to_sym)
      end
    end
  end

  describe '#sanitize_gem_content', :vcr do
    it 'sets the gem hash with name and version' do
      gemfile = Gemfile.new({ gemfile: "gem 'rails', '~> 3.12.2'" })
      expect(gemfile.gems).to eq({ 'rails' => '3.12.2' })
    end

    it 'handles >=' do
      gemfile = Gemfile.new({ gemfile: "gem 'rails', '>= 3.12.2'" })
      expect(gemfile.gems).to eq({ 'rails' => '3.12.2' })
    end

    it 'handles <=' do
      gemfile = Gemfile.new({ gemfile: "gem 'rails', '<= 3.12.2'" })
      expect(gemfile.gems).to eq({ 'rails' => '3.12.2' })
    end

    it 'handles >' do
      gemfile = Gemfile.new({ gemfile: "gem 'rails', '> 3.12.2'" })
      expect(gemfile.gems).to eq({ 'rails' => '3.12.2' })
    end

    it 'handles <' do
      gemfile = Gemfile.new({ gemfile: "gem 'rails', '< 3.12.2'" })
      expect(gemfile.gems).to eq({ 'rails' => '3.12.2' })
    end

    it 'handles =' do
      gemfile = Gemfile.new({ gemfile: "gem 'rails', '= 3.12.2'" })
      expect(gemfile.gems).to eq({ 'rails' => '3.12.2' })
    end

    it 'sets the version to empty string if not provided' do
      gemfile = Gemfile.new({ gemfile: "gem 'rails'" })
      expect(gemfile.gems).to eq({ 'rails' => '' })
    end
  end

  describe '#gem_path', :vcr do
    it 'returns the ruby gem path from rubygems.org' do
      expect(gemfile.gem_path('rails')).to eq 'https://rubygems.org/api/v1/gems/rails.json'
    end
  end
end
