require 'clockwork'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'boot'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'config', 'environment'))

module Clockwork
  every(1.hour, 'update_all_feeds') { UpdateAllFeedsJob.perform_later }
  every(1.hour, 'sync_all_playlists') { SyncAllPlaylistsJob.perform_later }
end
