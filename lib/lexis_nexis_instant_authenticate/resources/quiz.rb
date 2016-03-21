module LexisNexisInstantAuthenticate
  module Resources
    class Quiz < Base
      def questions
        product_response[:questions][:question]
      end

      def id
        product_response[:questions][:"@ns:quiz_id"]
      end

    end
  end
end