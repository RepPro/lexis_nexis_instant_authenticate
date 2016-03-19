#The unholiest of all...
#This monkey patch exists because LN requires a cleartext password to be sent with digest auth.
require 'akami'
module Akami
  class WSSE
    def wsse_username_token
      if digest?
        token = security_hash :wsse, "UsernameToken",
          "wsse:Username" => username,
          "wsse:Nonce" => Base64.encode64(nonce).chomp,
          "wsu:Created" => timestamp,
          "wsse:Password" => password,
          :attributes! => { "wsse:Password" => { "Type" => PASSWORD_TEXT_URI },  "wsse:Nonce" => { "EncodingType" => BASE64_URI } }
        # clear the nonce after each use
        @nonce = nil
      else
        token = security_hash :wsse, "UsernameToken",
          "wsse:Username" => username,
          "wsse:Password" => password,
          :attributes! => { "wsse:Password" => { "Type" => PASSWORD_TEXT_URI } }
      end
      token
    end
  end
end