class CodeBlockSerializer
  include FastJsonapi::ObjectSerializer
  attributes :code_type, :content
end
