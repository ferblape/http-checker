require "yaml"
require "http/client"

require "./notifier"

module HTTPChecker
  struct Check
    property domain
    property expected_code

    def initialize(@domain : String, @expected_code : Int)
    end
  end

  class Checker
    def initialize(checks_file : String)
      @sites :: Array(Check)

      @notifier = Notifier.new
      @sites = read_checks_file(checks_file)
    end

    def run
      @sites.each do |site|
        code = http_response_code(site.domain)
        if code != site.expected_code
          msg = "[#{Time.now.to_s("%Y%m%d %H:%M:%S")}] #{site.domain}: expected #{site.expected_code}, received #{code}"
          puts msg
          @notifier.notify msg
        else
          puts "[#{Time.now.to_s("%Y%m%d %H:%M:%S")}] #{site.domain} - \e[32mOK\!\e[0m \e[1m(#{code})\e[22m"
        end
      end
    end

    private def http_response_code(domain : String)
      response = HTTP::Client.get domain
      return response.status_code
    end

    private def read_checks_file(checks_file) : Array
      results = [] of Check

      file_content = YAML.load(File.read(checks_file)) as Array(YAML::Type)
      file_content.each do |check|
        if check.is_a?(Hash(YAML::Type, YAML::Type))
          domain = (check["domain"] as String)
          expected = (check["expected"] as String)

          results.push Check.new(domain, expected.to_i)
        end
      end

      results
    end
  end
end
