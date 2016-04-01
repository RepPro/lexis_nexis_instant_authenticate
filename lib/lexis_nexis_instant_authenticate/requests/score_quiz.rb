module LexisNexisInstantAuthenticate
  module Services
    class ScoreQuiz < Base

      def initialize(client, id, quiz_responses)
        @quiz_id = id
        @quiz_responses = quiz_responses
        @client = client
      end

      def responses_to_hash
        @quiz_responses.map do |resp| 
          { 
            "#{NAMESPACE}:questionId" => resp[:question_id],
            "#{NAMESPACE}:choiceId" => resp[:choice_id]
          }
        end
      end

      def request_body
        {
          score_request: {
            quiz_id: @quiz_id,
            answer: responses_to_hash
          }
        }
      end


    end
  end
end