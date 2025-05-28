# frozen_string_literal: true

require 'scryfall/base'

module Scryfall
  # Contains the methods for interacting with Scryfall's cards API endpoints
  class Cards < Scryfall::Base
    def self.search(query:, page: 1)
      params = { path: '/cards/search', q: query.encode }
      params[:page] = page unless page.nil? || page == 1
      api.get(params)
    end

    def self.named(query:, exact: false, set: nil)
      params = { path: '/cards/named', fuzzy: query.encode }
      params[:exact] = params.delete :fuzzy if exact
      params[:set] = set unless set.nil?
      api.get(params)
    end

    def self.random(query: nil)
      params = { path: '/cards/random' }
      params[:q] = query.encode unless query.nil?
      api.get(params)
    end

    def self.autocomplete(query:)
      params = { path: '/cards/autocomplete', q: query.encode }
      api.get(params)
    end

    def self.code_number_lang(code:, number:, lang: nil)
      params = { path: "/cards/#{code}/#{number}" }
      params[:path] += "/#{lang}" unless lang.nil?
      api.get(params)
    end
  end
end
