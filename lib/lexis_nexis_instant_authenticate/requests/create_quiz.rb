module LexisNexisInstantAuthenticate
  module Services
    class CreateQuiz < Base
      def initialize(client, person)
        @person = {dob: {}}.merge(person)
        @client = client
      end

      def request_body
        %{
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
                <ns:ssn>#{@person[:ssn]}</ns:ssn>
            </ns:person>
          </ns:inputSubject>
        }
      end


    end
  end
end