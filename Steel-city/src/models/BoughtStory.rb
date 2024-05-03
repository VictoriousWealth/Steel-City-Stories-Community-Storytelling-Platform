class BoughtStory < Sequel::Model(:bought_stories)
    # Method to check if an entry exists for a given story_id and user_id
    def self.entry_exists?(story_id, user_id)
      where(storyid: story_id, userid: user_id).count > 0
    end
    
end