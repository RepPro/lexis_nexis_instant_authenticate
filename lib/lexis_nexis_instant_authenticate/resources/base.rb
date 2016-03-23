module LexisNexisInstantAuthenticate
  module Resources
    class Base
      attr_reader :response
      def initialize(client, response)
        @client = client
        @response = response
      end

      def transaction_id
        @client.transaction_id
      end

      def proofing_response
        @response.hash[:envelope][:body][:invoke_identity_service_response][:identity_proofing_response]
      end

      def success?
        case status
        when "IDENTITY_NOT_LOCATED", "UNABLE_TO_GENERATE" then false
        else true
        end
      end

      def status
        proofing_response[:status]
      end

      def product_response
        proofing_response[:product_response]
      end

    end
  end
end