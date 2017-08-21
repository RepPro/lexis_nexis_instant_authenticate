require 'savon'
require_relative './akami_patch'
require_relative './requests/base'
require_relative './requests/create_quiz'
require_relative './requests/score_quiz'
require_relative './resources/base'
require_relative './resources/quiz'
require_relative './resources/score'

module LexisNexisInstantAuthenticate
  class Client
    def initialize(options = {})
      @options = options
    end

    def savon
      @savon ||= Savon.client(wsdl: wsdl_location) do |config|
        config.endpoint endpoint_location
        config.env_namespace :soapenv
        config.raise_errors @options[:production]
        config.log !@options[:production]
        config.log_level @options[:log_level] || :warn
        config.namespace_identifier "ws"
        config.proxy @options[:proxy]

        config.wsse_auth(@options[:username], @options[:password], :digest)
      end
    end

    def transaction_id
      if @options[:transaction_id]
        @options[:transaction_id]
      else
        @options[:transaction_id] = SecureRandom.uuid
        @options[:transaction_id]
      end
    end

    def create_quiz(person = {})
      response = call_service(Services::CreateQuiz.new(self, person).to_s)
      Resources::Quiz.new(self, response)
    end

    def score_quiz(id, responses)
      response = call_service(Services::ScoreQuiz.new(self, id, responses).to_s)
      Resources::Score.new(self, response)
    end

    def flow
      @options[:flow]
    end

    private
    def build_request
      savon.build_request(:invoke_identity_service)
    end

    def debug?
      savon.globals[:logger].debug?
    end

    def call_service(request_body, locals = {})
      request = build_request
      request.body = request_body
      if debug?
        savon.globals[:logger].debug request.body
      end
      response = Savon::Response.new(HTTPI.post(request), savon.globals, locals)
      if response.http_error
        fail "Bad HTTP response: #{response.http_error}"
      end
      if debug?
        savon.globals[:logger].debug response.hash.pretty_inspect
      end
      response
    end

    def wsdl_location
      if @options[:production]
        "https://identitymanagement.lexisnexis.com/identity-proofing/services/identityProofingServiceWS/v2?wsdl"
      else
        "https://staging.identitymanagement.lexisnexis.com/identity-proofing/services/identityProofingServiceWS/v2?wsdl"
      end
    end

    def endpoint_location
      if @options[:production]
      else
        "https://staging.identitymanagement.lexisnexis.com/identity-proofing/services/identityProofingServiceWS/v2"
      end
    end
  end
end

