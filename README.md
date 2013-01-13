# Mongoid::Slugs

Simple slugging for Mongoid models

## Installation

Add this line to your application's Gemfile:

    gem 'mongoid-slugs'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install mongoid-slugs

## Example Usage

```ruby
class Article
  include Mongoid::Document
  include Mongoid::Slugs

  field :title
  field :content

  slug_on :title
end
```

```ruby
article1 = Article.create(title: "This is a Test Article", content: "...")
article1.slug       #=> "this-is-a-test-article"
article1.to_param   #=> "this-is-a-test-article" 

article2 = Article.create(title: "This is a test article", content: "Another article")
article2.slug       #=> "this-is-a-test-article-1"

Article.find_by_slug("this-is-a-test-article")    #=> article1
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
