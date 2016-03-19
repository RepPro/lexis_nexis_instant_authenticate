module LexisNexisInstantAuthenticate
  module Services
    class Default
      def to_s
        %{
          <ns:identityProofingRequest ns:transactionID="?" ns:locale="?" ns:customerReference="?" ns:source="?">
            <ns:workFlow>REPPRO_FLOW</ns:workFlow>
            <ns:inputSubject>
              <ns:person>
                <ns:name>
                  <ns:first>CHRISTOPHER</ns:first>
                  <ns:last>OSTROWSKI</ns:last> 
                </ns:name>
                <ns:dateOfBirth> 
                  <ns:Year>1991</ns:Year> 
                  <ns:Month>07</ns:Month> 
                  <ns:Day>31</ns:Day>
                </ns:dateOfBirth>
                <ns:address ns:addressPurpose="PRIMARY_RESIDENCE">
                  <ns:addressLine1>25890 CONCORD RD</ns:addressLine1> 
                  <ns:city>HUNTINGTON WOODS</ns:city> 
                  <ns:stateCode>MI</ns:stateCode> 
                  <ns:zip5>48070</ns:zip5>
                </ns:address>
              </ns:person>
            </ns:inputSubject>
          </ns:identityProofingRequest>
        }
      end


    end
  end
end