class SegmentSerializer
  include FastJsonapi::ObjectSerializer
  attribute :segment_type

  attribute :text_block, if: proc { |record|
    record.segment_type == 'text_block'
  } do |object|
    TextBlockSerializer.new(object.text_block)
  end

  attribute :code_block, if: proc { |record|
    record.segment_type == 'code_block'
  } do |object|
    CodeBlockSerializer.new(object.code_block)
  end

  attribute :youtube_link, if: proc { |record|
    record.segment_type == 'youtube_link'
  } do |object|
    YoutubeLinkSerializer.new(object.youtube_link)
  end

  attribute :picture, if: proc { |record|
    record.segment_type == 'picture'
  } do |object|
    PictureSerializer.new(object.picture)
  end
end
