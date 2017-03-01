require 'json'

task :url do
  statefile = File.read('terraform.tfstate')
  state = JSON.parse(statefile)
  rest_api_id = state.dig("modules", 0, "resources", "aws_api_gateway_deployment.MyDemoDeployment", "primary", "attributes", "rest_api_id")
  puts "https://#{rest_api_id}.execute-api.eu-west-1.amazonaws.com/prod"
end
