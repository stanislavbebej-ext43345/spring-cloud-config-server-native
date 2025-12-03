http_response = http(input('url') + '/application/prod/default')

describe http_response do
  its('status') { should cmp 200 }
  its('headers.Content-Type') { should cmp 'application/json' }
end

describe json(content: http_response.body) do
  its(['propertySources', 0, 'name']) { should cmp 'overrides' }
  its(['propertySources', 1, 'name']) { should cmp 'file:/config/configServer/application-prod.yml' }
  its(['propertySources', 2, 'name']) { should cmp 'file:/config/configServer/application.yml' }
end
