module LexisNexisInstantAuthenticate
  module Services
    class CreateQuiz
      FLOW = "REPPRO_FLOW"
      def initialize(person, header)
        @person = {dob: {}}.merge(person)
        @header = header
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
                      <ns:inputSubject>
                         <ns:person>
                            <ns:name>
                               <ns:prefix></ns:prefix>
                               <ns:first>#{@person[:first_name]}</ns:first>
                               <ns:middle>#{@person[:middle_name]}</ns:middle>
                               <ns:last>#{@person[:last_name]}</ns:last>
                               <ns:suffix></ns:suffix>
                            </ns:name>
                            <ns:dateOfBirth>
                               <ns:Year>#{@person[:dob][:year]}</ns:Year>
                               <ns:Month>#{@person[:dob][:month]}</ns:Month>
                               <ns:Day>#{@person[:dob][:day]}</ns:Day>
                            </ns:dateOfBirth>
                            <ns:age>#{@person[:age]}</ns:age>
                            <ns:gender>#{@person[:gender]}</ns:gender>
                            <ns:ssn>#{@person[:gender]}</ns:ssn>
                        </ns:person>
                      </ns:inputSubject>
                   </ns:identityProofingRequest>
                </ws:invokeIdentityService>
             </soapenv:Body>
          </soapenv:Envelope>
        }
      end


    end
  end
end