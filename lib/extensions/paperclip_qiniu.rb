module Paperclip
  module Storage
    module Qiniu
      require 'open-uri'
      def copy_to_local_file(style, local_dest_path)
        log("copying #{path(style)} to local file #{local_dest_path}")
        url = download_url(path(style))
        if url
          local_file = ::File.open(local_dest_path, 'wb')
          file = open(url)
          local_file.write(file.read)
          local_file.close
          true
        else
          false
        end
      end

      def download_url(key, local_file_name = nil)
        ::Qiniu::RS.download(bucket, key, local_file_name)
      end
    end
  end
end
