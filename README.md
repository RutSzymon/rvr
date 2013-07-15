# rvr

REGON validator

## Installation

Add this line to your application's Gemfile:

    gem 'rvr'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rvr

## Usage

Just build new object of Rvr class with REGON number and call valid? method:

	Rvr.new("REGON NUMBER").valid?

## Example

	validate :verify_regon

	def verify_regon
	 	errors.add(:regon) unless Rvr.new(regon).valid?
	end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
