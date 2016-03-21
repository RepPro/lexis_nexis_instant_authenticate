module LexisNexisInstantAuthenticate
  module Services
    class CreateQuiz < Base

      def initialize(id, quiz_responses, header)
        @quiz_id = id
        @quiz_responses = quiz_responses
        @header = header
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

      def to_s
        %{
          <soapenv:Envelope 
             xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
             xmlns:ws="http://ws.identityproofing.idm.risk.lexisnexis.com/" 
             xmlns:ns="http://ns.lexisnexis.com/identity-proofing/1.0" 
             xmlns:ns1="http://ns.lexisnexis.com/survey/1.0">
              <soapenv:Header>
                #{@header}    
              </soapenv:Header>
             <soapenv:Body>
                <ws:invokeIdentityService>
                   <ns:identityProofingRequest ns:transactionID="#{rand(1..10000)}">
                      <ns:workFlow>#{FLOW}</ns:workFlow>
                      <ns:scoreRequest>
                        <ns:quizId>#{@quiz_id}</ns:quizId>
                        #{responses_to_xml}
                      </ns:scoreRequest>
                   </ns:identityProofingRequest>
                </ws:invokeIdentityService>
             </soapenv:Body>
          </soapenv:Envelope>
        }
      end


    end
  end
end