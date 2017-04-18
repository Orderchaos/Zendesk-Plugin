class ZendeskTicket
  def initialize(params)
    @client = ZendeskAPI::Client.new do |config|
      config.url = "#{ENV[SiteSetting.zendesk_url]]}/api/v2" # e.g. https://support.mydesk.com
      config.username = ENV[SiteSetting.zendesk_username]
      config.token = ENV[SiteSetting.zendesk_token]

      require 'logger'
      config.logger = Logger.new(File.expand_path("../../logs/zendesk.log", __FILE__))
    end
  end

  def url
    # ENV['ZENDESK_TICKET_URL'] => e.g. https://mydesk.newrelic.com
    "#{ENV[SiteSetting.zendesk_url]}/agent/#/tickets/#{@ticket.id}"
  end

  def status
    @ticket.status
  end

  def text
    return "View #{status.titleize} Zendesk Ticket"
  end

  def title
    case status
      when "new"      then "Ticket is New. "
      when "open"     then "Ticket is Open. "
      when "pending"  then "Ticket is Pending. "
      when "solved"   then "Ticket has been Solved. "
      when "closed"   then "Ticket has been Closed. "
      when "hold"     then "Ticket is on Hold. "
      else "Ticket status is unknown. "
    end + "Click to view in Zendesk"
  end

  def exists?
    @ticket.present?
  end
end
