require "http/client"

module HTTPChecker
  class Notifier
    def notify(msg)
      client = HTTP::Client.new "api.pushover.net", ssl: true
      response = client.post_form "/1/messages.json", {"token": ENV["HTTP_CHECKER_TOKEN"], "user": ENV["HTTP_CHECKER_USER"], "message": msg}
      client.close
    end
  end
end
