module LexisNexisInstantAuthenticate
  module Resources
    class Score < Base
      def pass?
        status != "FAIL"
      end

      def score
        h_dig(product_response, :quiz_score)
      end

      def quiz_id
        h_dig(product_response, :quiz_score, :"@ns:quiz_id")
      end

      def lex_id
        h_dig(product_response, :"@ns:lex_id")
      end

    end
  end
end