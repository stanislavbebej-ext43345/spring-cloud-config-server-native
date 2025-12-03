http_response = http(input('url') + '/actuator/health')

describe http_response do
  its('status') { should cmp 200 }
end

describe json(content: http_response.body) do
  its(['status']) { should cmp 'UP' }
end
