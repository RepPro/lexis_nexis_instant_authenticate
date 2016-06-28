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
        h_dig(@response.hash, :envelope, :body, :invoke_identity_service_response, :identity_proofing_response)
      end

      def success?
        case status
        when "IDENTITY_NOT_LOCATED", "UNABLE_TO_GENERATE" then false
        else true
        end
      end

      def status
        h_dig(proofing_response, :status)
      end

      def product_response
        h_dig(proofing_response, :product_response)
      end

      def h_dig(hash, *path)
        Array(path).inject(hash) do |location, key|
          location.respond_to?(:keys) ? location[key] : nil
        end
      end

    end
  end
end