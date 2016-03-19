require 'savon'
require_relative './akami_patch'
require_relative './requests/default.rb'

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

        config.wsse_auth(@options[:username], @options[:password], :digest)
      end
    end

    private
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

