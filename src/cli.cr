require "./http-check"

checker = HTTPChecker::Checker.new(ARGV[0])
checker.run
