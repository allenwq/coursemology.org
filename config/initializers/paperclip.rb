Paperclip::Attachment.default_options[:path] = ':class/:attachment/:id_partition/:style/:filename'

Paperclip::Attachment.default_options[:storage] = :qiniu
Paperclip::Attachment.default_options[:qiniu_credentials] = {
    :access_key => ENV['QINIU_ACCESS_KEY'] || raise('No QINIU_ACCESS_KEY'),
    :secret_key => ENV['QINIU_SECRET_KEY'] || raise('No QINIU_SECRET_KEY')
}
Paperclip::Attachment.default_options[:bucket] = 'coursemology'
Paperclip::Attachment.default_options[:use_timestamp] = false
Paperclip::Attachment.default_options[:qiniu_host] = 'http://store.coursemology.cn'

