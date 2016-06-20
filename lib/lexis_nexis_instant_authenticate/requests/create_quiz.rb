module LexisNexisInstantAuthenticate
  module Services
    class CreateQuiz < Base
      def initialize(client, person)
        @person = {dob: {}, address: {}}.merge(person)
        @client = client
      end

      def request_body
        {
          input_subject: {
            person: {
              name: nil_to_string(name),
              date_of_birth: nil_to_string(date_of_birth),
              age: nil_to_string(age),
              gender: nil_to_string(gender),
              ssn: nil_to_string(ssn),
              address: nil_to_string(address),
              email: nil_to_string(email)
            }
          }
        }
      end

      private
      def name
        {prefix: "", first: @person[:first_name], middle: @person[:middle_name], last: @person[:last_name], suffix: ""}
      end

      def date_of_birth
        {year: @person[:dob][:year], month: @person[:dob][:month], day: @person[:dob][:day]}
      end

      def age
        @person[:age]
      end

      def gender
        return "" unless @person[:gender].present?
        return @person[:gender].capitalize[0] if @person[:gender].length > 1
        return @person[:gender]
      end

      def ssn
        @person[:ssn].present? && @person[:ssn].gsub(/\D/, "")
      end

      def address
        {
          street_address_1: @person[:address][:line_1],
          street_address_2: @person[:address][:line_2],
          city: @person[:address][:city],
          state: @person[:address][:state],
          zip5: @person[:address][:zip_code]
        }
      end

      def email
        @person[:email]
      end

    end
  end
end
