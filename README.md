# http-check

`http-check` is a small HTTP status checker written in Crystal, which notifies any unexpected HTTP
status using https://pushover.net/

## Installation

1 - Copy the binary `bin/http-checker` wherever you want.

2 - Set both `HTTP_CHECKER_TOKEN` and `HTTP_CHECKER_USER` environment variables with the token of
your application and your user token.

3 - Maybe you want to enable the binary in cron.

## Usage

Create a file with the list of domains and expected HTTP status code (as an example, we provide the
`sites.yml` file).

Just call `$ checker sites.yml`

## Contributing

1. Fork it ( https://github.com/ferblape/http-check/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [ferblape](https://github.com/ferblape) Fernando Blat - creator, maintainer