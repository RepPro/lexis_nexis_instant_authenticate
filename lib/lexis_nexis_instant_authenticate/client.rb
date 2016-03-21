require 'savon'
require_relative './akami_patch'
require_relative './requests/create_quiz'
require_relative './resources/quiz'

module LexisNexisInstantAuthenticate
  class Client
    def initialize(options = {})
      @options = options
    end

    def client
      @client ||= Savon.client(wsdl: wsdl_location) do |config|
        config.endpoint endpoint_location
        config.env_namespace :soapenv
        config.raise_errors @options[:production]
        config.log !@options[:production]
        config.namespace_identifier "ws"

        config.wsse_auth(@options[:username], @options[:password], :digest)
      end
    end

    def create_quiz(person = {})
      response = call_service(Services::CreateQuiz.new(person, header).to_s)
      Resources::Quiz.new(response.hash)
    end

    private
    def build_request
      client.build_request(:invoke_identity_service)
    end

    def call_service(request_body, locals = {})
      request = build_request
      request.body = request_body
      Savon::Response.new(HTTPI.post(request), client.globals, locals)
    end

    def header
      Savon::Header.new(client.globals, {})
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

