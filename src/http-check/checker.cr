require "yaml"
require "http/client"

class Http::Check::Checker
  def initialize(checks_file : String)
    @checks_file = checks_file
  end

  def run
    sites = YAML.load(File.read(@checks_file))

    if sites.is_a?(Array)
      sites.each do |site|
        if site.is_a?(Hash) && site["domain"].is_a?(String) && site["expected"].is_a?(String)
          code = http_response_code(site["domain"])
          expected = site["expected"]
          if code != expected
            msg = "[#{Time.now.to_s("%Y%m%d %H:%M:%S")}] #{site["domain"]}: expected #{site["expected"]}, received #{code}"
            puts msg
          else
            puts "[#{Time.now.to_s("%Y%m%d %H:%M:%S")}] #{site["domain"]} - OK! (#{expected})"
          end
        else
          puts "Invalid YAML format"
        end
      end
    else
      raise "Invalid YAML format"
    end
  end

  def notify(msg)
    client = HTTP::Client.new "api.pushover.net", ssl: true
    response = client.post_form "/1/messages.json", {"token": ENV["HTTP_CHECKER_TOKEN"], "user": ENV["HTTP_CHECKER_USER"], "message": msg}
    client.close
  end

  def http_response_code(domain)
    if domain.is_a?(String)
      response = HTTP::Client.get domain
      return response.status_code.to_s
    end
  end
end

checker = Http::Check::Checker.new(ARGV[0])
checker.run
