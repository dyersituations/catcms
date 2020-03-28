# Fix for open CarrierWave issue: https://github.com/diogob/carrierwave-postgresql/issues/33.
module CarrierWave
  class Mounter
    def remove_previous(before=nil, after=nil)
      after ||= []
      return unless before

      # Both 'before' and 'after' can be string when 'mount_on' option is set.
      before = before.reject(&:blank?).map do |value|
        if value.respond_to?(:path)
          value
        else
          uploader = blank_uploader
          uploader.retrieve_from_store!(value)
          uploader
        end
      end
      after_paths = after.reject(&:blank?).map do |value|
        if value.respond_to?(:path)
          value
        else
          uploader = blank_uploader
          uploader.retrieve_from_store!(value)
          uploader
        end.path
      end
      before.each do |uploader|
        if uploader.remove_previously_stored_files_after_update and not after_paths.include?(uploader.path)
          uploader.remove!
        end
      end
    end
  end
end
