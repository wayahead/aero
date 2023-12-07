abstract class BaseSerializer < Lucky::Serializer
  def self.for_collection(collection : Enumerable, *args, **named_args)
    {
      self.collection_key => collection.map do |object|
        new(object, *args, **named_args)
      end
    }
  end

  def self.for_collection(collection : Enumerable, pages : Lucky::Paginator, *args, **named_args)
    {
      self.collection_key => collection.map do |object|
        new(object, *args, **named_args)
      end,
      # Add pagination metadata to the response
      "pagination" => {
        next_page: pages.path_to_next,
        previous_page: pages.path_to_previous,
        total_items: pages.item_count,
        total_pages: pages.total
      }
    }
  end
end
