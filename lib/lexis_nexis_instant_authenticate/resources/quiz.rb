module LexisNexisInstantAuthenticate
  module Resources
    class Quiz
      def initialize(response_hash = {})
        @response_hash = response_hash
      end

      def response
        @response_hash[:envelope][:body][:invoke_identity_service_response][:identity_proofing_response]
      end

      def success?
        case status
        when "IDENTITY_NOT_LOCATED" then false
        else true
        end
      end

      def status
        response[:status]
      end

      def product_response
        response[:product_response]
      end

      def questions
        product_response[:questions][:question]
      end

      def id
        product_response[:questions][:"@ns:quiz_id"]
      end




    end
    
  end
      
end