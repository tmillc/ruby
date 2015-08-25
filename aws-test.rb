require 'aws-sdk'
require 'yaml'

# load credentials from disk 
# 'secrets' is user canderson, 'secrets2' is user archiver
creds = YAML.load(File.read('secrets2'))

s3 = Aws::S3::Client.new(
  access_key_id: creds['access_key_id'],
  secret_access_key: creds['secret_access_key'],
  region: 'us-west-2'
)

# creating/configuring a bucket should be a one-time thing

# TODO: get actual name of TIMESTAMP.backup.gz

# upload to S3
File.open('TIMESTAMP.backup.gz', 'rb') do |file|
  s3.put_object(bucket: 'archivebucketname', key: 'TIMESTAMP.backup.gz', body: file)
end

# TODO: remove TIMESTAMP.backup.gz locally
