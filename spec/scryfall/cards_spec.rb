# frozen_string_literal: true

require 'scryfall'

RSpec.describe Scryfall::Cards do
  context 'search' do
    it 'returns a JSON response containing the search results' do
      VCR.use_cassette('successful search') do
        expect(Scryfall::Cards.search(query: 'c:c cmc=15')['data'].length).to eq(2)
      end
    end
  end

  context 'named' do
    context 'fuzzy' do
      it 'returns a JSON response containing the data for the specified card' do
        VCR.use_cassette('successful fuzzy named') do
          expect(Scryfall::Cards.named(query: 'jac bel')['name']).to eq('Jace Beleren')
        end
      end
    end

    context 'exact' do
      it 'returns a JSON response containing the data for the specified card' do
        VCR.use_cassette('successful exact named') do
          expect(Scryfall::Cards.named(query: 'jace beleren', exact: true)['name']).to eq('Jace Beleren')
        end
      end
    end
  end

  context 'random' do
    it 'returns a JSON response containing the data for a random card' do
      VCR.use_cassette('successful random search') do
        expect(Scryfall::Cards.random(query: nil)['object']).to eq('card')
      end
    end

    it 'returns a JSON response containing the data for a filtered random card search' do
      VCR.use_cassette('successful filtered random search') do
        expect(Scryfall::Cards.random(query: 'Jace')['name']).to start_with 'Jace'
      end
    end
  end

  context 'code_number_lang' do
    it 'returns a JSON response containing a single card in English' do
      VCR.use_cassette('successful code number lang english') do
        expect(Scryfall::Cards.code_number_lang(code: 'xln', number: 96)['name']).to eq('Costly Plunder')
      end
    end

    it 'returns a JSON response containing a single card in Italian' do
      VCR.use_cassette('successful code number lang italian') do
        expect(Scryfall::Cards.code_number_lang(code: 'xln', number: 96, lang: 'it')['printed_name'])
          .to eq('Saccheggio a Caro Prezzo')
      end
    end

    context 'autocomplete' do
      it 'returns a JSON response containing data that could be autocompletions of given string' do
        VCR.use_cassette('successful autocomplete') do
          expect(Scryfall::Cards.autocomplete(query: 'ja')['data'].length).to eq(20)
        end
      end
    end
  end
end
