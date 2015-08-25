# This file currently just reformatted http://www.spacevatican.org/2012/9/4/using-glacier-with-fog/

=begin Creating a vault
A vault is a collection of many archives. 
An archive is a single file stored in a vault and jobs are how you ask 
Glacier to perform retrieval operation. Fog’s glacier support includes models, 
so creating a vault is done like this:
=end

glacier = Fog::AWS::Glacier.new
vault = glacier.vaults.create :id => 'myvault'
#=>   <Fog::AWS::Glacier::Vault
# id="myvault",
# created_at=2012-09-03 19:22:47 UTC,
# last_inventory_at=nil,
# number_of_archives=0,
# size_in_bytes=0,
# arn="arn:aws:glacier:us-east-1:1234567890123456:vaults/myvault"

=begin Getting data into Glacier
=end

vault.archives.create(:body => 'data', :description => 'my first archive')
# =>   <Fog::AWS::Glacier::Archive
# id="gTesVWGCyKvv07zdXiYnbjvjIBpWKPi_F80dLklgpGSfoE_zj4htSy8mNuZNuMrGIzKT8WNgmKtirq_ZxL3bYj3G-3nw",
# description="my first archive",
# body="data"

=begin Chunk Size
For larger files you’ll want to use multipart mode by supplying a file 
(or IO instance) as the body and the chunk size to use (must be a power 
of 2 multiple of 1MB).
With a smaller part size you’ll waste less time if you need to retry 
chunks and you’ll use less memory but there will be more overhead from 
opening a connection every 1MB of the way. There is also a hard limit 
of 10000 chunks per upload, so you’ll need bigger chunks for large 
uploads. Fog uploads parts one at a time but if you drop down to the 
raw api you can upload parts in any order you want, and multiple parts 
at a time.
=end

vault.archives.create :body => File.new('somefile'), :multipart_chunk_size => 1024*1024

=begin What's in a vault
If you want to know what’s in a vault, arm yourself with patience and 
create an inventory retrieval job. After 3-4 hours the job will complete 
and you can request its output. The get_output method returns an 
Excon::Response whose body is the data you’re interested in: a json 
document describing the vault’s contents.
=end

# inventory retrieval job:
vault.jobs.create(:type => Fog::AWS::Glacier::Job::INVENTORY)
# =>   <Fog::AWS::Glacier::Job
#    id="SsRqiT0MNuA9bZy6EhCN9klYXOHtuiOsxZHa0vjGna-zQqTLCY4nbHpMLt-12aL4kZryUjoCvd-a",
#    action="InventoryRetrieval",
#    ...

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

=begin   Vault Inventory
The vault inventory only gets updated once a day: the 4 hour job just 
retrieves the last computed inventory rather than calculating a fresh 
one. If you want something more up to date or with more information 
about the archives you’ll have to store that information outside of 
glacier. The list of vaults in your account is instantly accessible so 
if you don’t have too much data you could store each archive in its own 
vault (you’re limited to 1000 vaults per region).
=end

=begin SNS Integration
You can wait for the job to complete by polling, using the usual 
job.wait_for {ready?} idiom but you’re much better off using Glacier’s 
SNS integration. You can set this up on a per job basis:
=end

# per job SNS
vault.jobs.create :type => Fog::AWS::Glacier::Job::INVENTORY,
                  :sns_topic => 'arn:aws:sns:us-east-1:1234567890123456:mytopic'
                  
# or for all jobs linked to a vault
vault.set_notification_configuration 'arn:aws:sns:us-east-1:1234567890123456:mytopic',
                                 %w(ArchiveRetrievalCompleted InventoryRetrievalCompleted)

# Retrieving the job, then can get its output
job = vault.jobs.get(job_id)

=begin Retrieving Archives
Again, be prepared to wait a 3-4 hours for the job to complete. With 
archives you’ll often not want to load the whole archive into memory 
(which is what get_output does by default). Instead you can stream the 
output to an IO instance (such as a file)
=end

# You retrieve an archive by creating an archive retrieval job.
vault.jobs.create(:type => Fog::AWS::Glacier::Job::ARCHIVE, :archive_id => '...' )

# Stream to IO instance
File.open('myarchive') do |f|
  job.get_output :io => f
end

# Retrieve portions of a file, ie first 500 bytes of an archive:
File.open('myarchive', :range => 0...500) do |f|
  job.get_output :io => f
end
