require 'net/http'

module NewGoogleRecaptcha
  class Validator
    attr_reader :score
    attr_reader :token, :minimum_score

    def initialize(token:, minimum_score:)
      @token         = token
      @minimum_score = minimum_score
    end

    def call
      uri = NewGoogleRecaptcha.compose_uri(token)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true if uri.scheme == 'https'
      result = JSON.parse(http.request(Net::HTTP::Get.new(uri)).body)

      @score = result['score'].to_f

      conditions = []
      conditions << !!result['success']
      conditions << (result['score'].to_f >= minimum_score)
      conditions.none?(&:!)
    end
  end
end