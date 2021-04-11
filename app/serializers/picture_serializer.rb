class PictureSerializer
  include FastJsonapi::ObjectSerializer
  attribute :external_link, if: proc { |record| record.external_link }
  attribute :cloudinary_link, if: proc { |record| record.photo.attached? } do |object|
    Cloudinary::Utils.cloudinary_url(object.photo.key)
  end
end
