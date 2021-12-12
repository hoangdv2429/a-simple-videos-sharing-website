class Video < ApplicationRecord
    has_one_attached :clip
    has_one_attached :thumbnail
    # belongs_to :user 
    # has_many_attached :comment 


    validates :title, presence: true
    validates :description, presence: true
    validate :correct_image_type
    validate :correct_video_type

    private 

    def correct_image_type
        if (thumbnail.attached? && !thumbnail.content_type.in?(%w(image/jpeg image/png)))
            errors.add(:thumbnail, 'must be a JPEG or PNG.')
        elsif thumbnail.attached? ==false
            errors.add(:thumbnail, 'must be attached.')
        end
    end

    def correct_video_type
        if(clip.attached? && !clip.content_type.in?(%w(video/mp4)))
            errors.add(:clip, 'must be MP4.')
            elsif clip.attached? ==false
            errors.add(:clip, 'must be attached.')
        end
    end
end
