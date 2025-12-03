http_response = http(input('url') + '/encrypt',
  method: 'POST',
  headers: {
    'Content-Type' => 'text/plain'
  },
  data: 'samplePassword'
)

describe http_response do
  its('status') { should cmp 200 }
  its('body') { should match /^[a-fA-F0-9]{64}$/ }
end
