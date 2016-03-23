# LexisNexisInstantAuthenticate

Generate & Score Instant Authenicate quizes using Lexis Nexis SOAP API.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'lexis_nexis_instant_authenticate'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install lexis_nexis_instant_authenticate

## Usage

###Create a client.
```ruby
@client = LexisNexisInstantAuthenticate::Client.new(username: ENV['LEXIS_UN'], password: ENV['LEXIS_PW'], flow: "LEXIS_FLOW", transaction_id: SecureRandom.uuid)
```

Options:
 * `username:` Lexis Nexis supplied username. Typically, "#{account_id}/#{username}"
 * `password:` Lexis Nexis supplied password.
 * `flow:` Name of workflow.
 * `transaction_id:` Optional GUID. This must be the same string between quiz creation & quiz scoring requests. If you do not pass one in on quiz creation, `SecureRandom.uuid` will be used and returned with the generated quiz. That same string must be sent when scoring quiz.

###Generate a quiz.
```ruby
  response = @client.create_quiz({first_name: "Joe", middle_name: "L", last_name: "Smith", ssn: "123456789", dob: {day: "01", month: "01", year: "1950"}})
  if response.success?
    return response
  else
    return response.status
  end
```

Response will have:
* `response.questions`
* `response.id`
* `response.transaction_id`




## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/RepPro/lexis_nexis_instant_authenticate.

