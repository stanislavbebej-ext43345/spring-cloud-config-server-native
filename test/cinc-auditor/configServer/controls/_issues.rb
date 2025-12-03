title 'GitHub Issues'

http_response = http(input('url') + '/default/application-prod.yml')

control 'issue-2327' do
  impact 'low'
  title 'YAML: dotted attributes escape sequence'
  ref '#2327', url: 'https://github.com/spring-cloud/spring-cloud-config/issues/2327'
  tag 'issue'

  describe yaml(content: http_response.body) do
    its(['annotations', 'default', 'app.acme.com/source']) { should cmp 'https://github.com/acme/sample-app' }
  end
end

control 'issue-2746' do
  impact 'high'
  title 'Spring Cloud Config returns an empty string instead of an empty array'
  ref '#2746', url: 'https://github.com/spring-cloud/spring-cloud-config/issues/2746'
  tag 'issue'

  describe yaml(content: http_response.body) do
    its(['empty', 'array']) { should cmp [] }
  end
end
