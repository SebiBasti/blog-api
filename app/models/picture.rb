class Picture < ApplicationRecord
  belongs_to :segment
  has_one_attached :photo
  validate :external_xor_cloudinary
  validate :photo_or_link_present?

  private

  def external_xor_cloudinary
    # https://stackoverflow.com/questions/2134188/validate-presence-of-one-field-or-another-xor
    unless (external_link.blank? ^ photo.blank?) || (external_link.blank? && photo.blank?)
      errors.add :base, message: 'Photo can either be uploaded or linked, not both'
    end
  end

  def photo_or_link_present?
    if external_link.blank? && photo.blank?
      errors.add :base, message: 'No photo attached or linked.'
    end
  end
end
