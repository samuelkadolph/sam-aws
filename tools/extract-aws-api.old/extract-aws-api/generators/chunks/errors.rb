module Generators
  module Chunks
    class ErrorClass < ErrorBase
      contents do
        line description.comment!
        line %Q{class #{name}Error < APIError}
        line %Q{end}
      end
    end
  end
end
