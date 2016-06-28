module LexisNexisInstantAuthenticate
  module Resources
    class Score < Base
      def pass?
        status != "FAIL"
      end

      def score
        h_dig(proofing_response, :quiz_score)
      end

      def quiz_id
        h_dig(proofing_response, :quiz_score, :"@ns:quiz_id")
      end

      def lex_id
        h_dig(proofing_response, :"@ns:lex_id")
      end

    end
  end
end