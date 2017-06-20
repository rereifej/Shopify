require 'csv'
require 'json'
require 'rest-client'
require 'time'
require 'yaml'

CONFIG = YAML.load_file('config.yml')
SHOP_AUTH = "https://#{CONFIG[:api_key]}:#{CONFIG[:password]}@#{CONFIG[:store]}"
CYCLE = 0.5

def getCustomers()
  action = '/admin/customers.json'
  get_url = SHOP_AUTH + action
  response = RestClient.get(get_url)
  response = JSON.parse(response)
  return response['customers']
end

def getActivationUrl(customer_id)
  action = "/admin/customers/#{customer_id}/account_activation_url.json"
  post_url = SHOP_AUTH + action
  post_request = { "customer" => { "id" => customer_id } }
  begin
    response = RestClient.post(post_url, post_request)
    response = JSON.parse(response)
    response = response['account_activation_url']
  rescue => e
    response = e.response
    response = JSON.parse(response)
    response = response['errors']
  end
  return response
end

customers = getCustomers
start_time = Time.now
csv_rows = Array.new

customers.each do |customer|
  stop_time = Time.now
  processing_duration = stop_time - start_time
  wait_time = (CYCLE - processing_duration).ceil
  sleep wait_time if wait_time > 0
  start_time = Time.now
  activation_url = getActivationUrl(customer['id'])
  csv_rows << {:email => customer['email'], :activation_url => activation_url}
  puts activation_url
end

CSV.open('activation_urls.csv', 'w') do |csv|
  csv_rows.each do |row|
    csv << [row[:email], row[:activation_url]]
  end
end
