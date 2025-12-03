http_response = http(input('url') + '/application/prod/default/application.yml')

describe http_response do
  its('status') { should cmp 200 }
  its('body') { should match /spring-cloud\/spring-cloud-config\/issues\/2327/ }
end
