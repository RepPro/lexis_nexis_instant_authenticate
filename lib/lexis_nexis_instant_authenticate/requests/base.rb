module LexisNexisInstantAuthenticate
  module Services
    class Base
      def header
        Savon::Header.new(@client.savon.globals, {})
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
                   <ns:identityProofingRequest ns:transactionID="#{transaction_id}">
                      #{xml_body}
                   </ns:identityProofingRequest>
                </ws:invokeIdentityService>
             </soapenv:Body>
          </soapenv:Envelope>
        }
      end

      def xml_body
      end

      def transaction_id
        @transaction_id ||= SecureRandom.uuid
      end


    end
  end
end