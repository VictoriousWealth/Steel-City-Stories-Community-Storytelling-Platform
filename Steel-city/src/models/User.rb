require "require_all"

class User < Sequel::Model
    def self.enough_popcorns?(story_id, user_id)
        story = Story[storyid: story_id]
        user = User[userid: user_id]

        return false if story.nil? || user.nil?

        popcorns = user.popcorns
        price = story.price
        popcorns >= price
    end
end