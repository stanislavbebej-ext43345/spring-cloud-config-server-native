acme_key = 'app.acme.com/source'
acme_value = 'https://github.com/acme/sample-app'

http_response = http(input('url') + '/default/application-prod.yml')

describe http_response do
  its('status') { should cmp 200 }
  its('headers.Content-Type') { should cmp 'text/plain' }
end

describe yaml(content: http_response.body) do
  its(['empty', 'array']) { should cmp [] }
  its(['x-dot']) { should cmp '.' }
  its(['x-github', 'sha']) { should match /^[a-fA-F0-9]{7,}$/ }
end

describe.one do
  describe yaml(content: http_response.body) do
    its(['annotations', 'default', acme_key]) { should cmp acme_value }
  end

  describe yaml(content: http_response.body) do
    its(['annotations', 'double', acme_key]) { should cmp acme_value }
  end

  describe yaml(content: http_response.body) do
    its(['annotations', 'single', acme_key]) { should cmp acme_value }
  end

  describe yaml(content: http_response.body) do
    its(['annotations', 'hack', acme_key]) { should cmp acme_value }
  end

  describe yaml(content: http_response.body) do
    its(['annotations', 'doubleBracket', acme_key]) { should cmp acme_value }
  end

  describe yaml(content: http_response.body) do
    its(['annotations', 'singleBracket', acme_key]) { should cmp acme_value }
  end
end
