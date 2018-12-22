
# Tangled.rb

Tangled is a abstract layer around the IOTA Core Library. It helps to simplify development on top of the 'Tangle'. The distributed ledger of the IOTA Foundation.

## Table of Contents
- [Installation](#installation)
- [Usage](#usage)
  - [Account](#account)
    - [Account Information](#account_information)
    - [Generate Address](#generate_address)
    - [Create transfer](#create_transfer)
    - [Transfers](#transfers)
  - [Transfer](#transfer)
    - [Transactions](#transactions)
  - [Transaction](#transaction)
    - [Value](#value)
    - [Confirmed](#confirmed)
    - [Message](#message)
  - [Node](#node)
    - [Node Information](#node_information)
    - [Neighbors](#neighbors)
    - [Synced](#synced)
- [Development](#development)
- [Contributing](#contributing)
- [License](#license)

## Installation
Add this line to your application's Gemfile:
```ruby
gem 'tangled'
```

And then execute:

$ bundle

Or install it yourself as:

$ gem install tangled

## Usage
Before you can access any data you will need to configure the library. You can do that by adding the following code

```ruby
Tangled.configure do |config|
  config.node  =  'your-node-url'
end

# Example seed generator for testing only
# Do not use in real-life situations!
seed = Tangled::Seed.generate
```

### Account

#### Account Information
Get account information such as balance and addresses.
```ruby
Tangled::Account.new(seed).info

# Response
{
 balance:  0,
 transfers:  [],
 latest_address: ..,
 addresses:  [],
 inputs:  []
}
```

#### Generate address
Generate a new address and add it to the tangle.
```ruby
Tangled::Account.new(seed).generate_address

# Response
"999..."
```

#### Create transfer
Send message to another account, with optional value.
```ruby
address_to = "999..." # Address from receiver
message = "hello" # Message string
value = 1 # Iota's to send *optional*
Tangled::Account.new(seed).create_transfer(address_to, message, value)

# Response
[Tangled::Transaction.class, ..]
```

#### Transfers
Get list of previous transfers
```ruby
Tangled::Account.new(seed).transfers

# Response
[Tangled::Transfer.class, ..]
```

### Transfer

#### Transactions
Get a list of transactions from transfer
```ruby
Tangled::Account.new(seed).transfers

# Response
[Tangled::Transfer.class, ..]
```

### Transaction

#### Value
Get value from transaction
```ruby
transaction = Tangled::Account.new(seed).transfers.first.transactions.first
transaction.value

# Response
0
```

#### Confirmed
Get value from transaction
```ruby
transaction = Tangled::Account.new(seed).transfers.first.transactions.first
transaction.confirmed?

# Response
true || false
```

#### Message
Get message from transaction
```ruby
transaction = Tangled::Account.new(seed).transfers.first.transactions.first
transaction.message

# Response
"Message string already converted from trytes"
```

### Node

#### Node Information
Get account information such as balance and addresses.
```ruby
Tangled::Node.new.info

# Response
{
   'app_name': 'IRI Testnet',
   'app_version': '1.5.5',
   'duration': 1,
   ...
}
```

#### Neighbors
Get account information such as balance and addresses.
```ruby
Tangled::Node.new.neighbors

# Response
{
    "duration": 37,
    "neighbors": [
        {
            "address": "/8.8.8.8:14265",
            "numberOfAllTransactions": 922,
            "numberOfInvalidTransactions": 0,
            "numberOfNewTransactions": 92
        },
        ...
    ]
}
```

#### Neighbors
Get account information such as balance and addresses.
```ruby
Tangled::Node.new.synced?

# Response
true || false
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/tangledit/tangled.rb. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
