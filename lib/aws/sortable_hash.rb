module AWS
  require "aws/hash_sorting"

  class SortableHash < Hash
    include HashSorting
  end
end
