module LexisNexisInstantAuthenticate
  module Services
    class ScoreQuiz < Base

      def initialize(client, id, quiz_responses)
        @quiz_id = id
        @quiz_responses = quiz_responses
        @client = client
      end

      def responses_to_xml
        @quiz_responses.map do |resp|
          %{
            <ns:answer>
              <ns:questionId>#{resp[:question_id]}</ns:questionId>
              <ns:choiceId>#{resp[:choice_id]}</ns:choiceId> 
            </ns:answer>
          }
        end.join("\n")
      end

      def request_body
        %{
          <ns:scoreRequest>
            <ns:quizId>#{@quiz_id}</ns:quizId>
            #{responses_to_xml}
          </ns:scoreRequest>
        }
      end


    end
  end
end