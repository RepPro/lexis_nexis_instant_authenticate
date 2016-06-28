require 'gyoku'

module LexisNexisInstantAuthenticate
  module Services
    class Base
      NAMESPACE = "ns".freeze

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
                #{header}  
              </soapenv:Header>
             <soapenv:Body>
                <ws:invokeIdentityService>
                   <ns:identityProofingRequest ns:transactionID="#{@client.transaction_id}">
                      <ns:workFlow>#{@client.flow}</ns:workFlow>
                      #{to_xml}
                   </ns:identityProofingRequest>
                </ws:invokeIdentityService>
             </soapenv:Body>
          </soapenv:Envelope>
        }
      end

      def camelize(term)
        term.to_s.split('_').each_with_index.map do |w,idx| 
          if idx == 0
            next w
          else
            next w.capitalize
          end
        end.join()
      end

      def to_xml
        Gyoku.xml(request_body, key_converter: -> key { [NAMESPACE, camelize(key)].join(':') })
      end

      def request_body
        {}
      end

      def nil_to_string(object)
        case object
        when Hash then object.each {|k,v| object[k] = "" if v.nil?}
        else object = "" if object.nil?
        end
        return object
      end


    end
  end
end
