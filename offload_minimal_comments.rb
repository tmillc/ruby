# Create a vault
glacier = Fog::AWS::Glacier.new
vault = glacier.vaults.create :id => 'myvault'

# Get data into Glacier
vault.archives.create(:body => 'data', :description => 'my first archive')

# Specifying chunk size
vault.archives.create :body => File.new('somefile'), :multipart_chunk_size => 1024*1024

# inventory retrieval job:
vault.jobs.create(:type => Fog::AWS::Glacier::Job::INVENTORY)

# After completed, requesting its output:
job.get_output.body
=>
{"VaultARN"=>"arn:aws:glacier:us-east-1:1234567890123456:vaults/vault1",
 "InventoryDate"=>"2012-09-04T00:02:26Z",
 "ArchiveList"=>
  [{"ArchiveId"=>
     "PXK1d6pQPtNDkoLxAtuzyvjrV7pVXiakLgMMZ7p0i7b2slXTXV7JP2mVFDc-mgOMkhwn7lA0Izn5jFKxYIKAQoHzA",
    "ArchiveDescription"=>"",
    "CreationDate"=>"2012-09-01T17:01:09Z",
    "Size"=>4,
    "SHA256TreeHash"=>
     "3a6eb0790f39ac87c94f3856b2dd2c5d110e6811602261a9a923d3bb23adc8b7"},
   {"ArchiveId"=>
     "kbB38fFWfaWvhUG7H-iBg8vPqr0Y1uwcY0nTxw4ETOJnOBudWhrTy3IOTxUKkmRHdmIkHt2e-e-OFmfvndj2T_REg",
    "ArchiveDescription"=>"",
    "CreationDate"=>"2012-09-02T00:14:37Z",
    "Size"=>9756860,
    "SHA256TreeHash"=>
     "a4b72323790e372e71e631c240dfa7aa4f43d78e5f49243a589ca3f2a87a14cd"}
  ]}

# per job SNS, instead of job.wait_for {ready?} idiom
vault.jobs.create :type => Fog::AWS::Glacier::Job::INVENTORY,
                  :sns_topic => 'arn:aws:sns:us-east-1:1234567890123456:mytopic'
                  
# SNS for all jobs linked to a vault
vault.set_notification_configuration 'arn:aws:sns:us-east-1:1234567890123456:mytopic',
                                 %w(ArchiveRetrievalCompleted InventoryRetrievalCompleted)

# Retrieving the job, then can get its output
job = vault.jobs.get(job_id)

# Retrieve an archive by creating an archive retrieval job.
vault.jobs.create(:type => Fog::AWS::Glacier::Job::ARCHIVE, :archive_id => '...' )

# Stream to IO instance
File.open('myarchive') do |f|
  job.get_output :io => f
end

# Retrieve portions of a file, ie first 500 bytes of an archive:
File.open('myarchive', :range => 0...500) do |f|
  job.get_output :io => f
end
