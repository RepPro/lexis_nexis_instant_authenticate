module LexisNexisInstantAuthenticate
  module Resources
    class Quiz < Base
      def questions
        h_dig(product_response, :questions, :question)
      end

      def id
        h_dig(product_response, :questions, :"@ns:quiz_id")
      end

    end
  end
end