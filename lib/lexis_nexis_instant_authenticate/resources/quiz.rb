module LexisNexisInstantAuthenticate
  module Resources
    class Quiz < Base
      def questions
        h_dig(proofing_response, :questions, :question)
      end

      def id
        h_dig(proofing_response, :questions, :"@ns:quiz_id")
      end

    end
  end
end