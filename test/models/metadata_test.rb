require "test_helper"

class MetadataTest < ActiveSupport::TestCase
  test "tittle attribute" do
    metadata = Metadata.new('<title>My Title</title>')
    assert_equal 'My Title', metadata.title
  end

  test "missing title attribute" do
    metadata = Metadata.new('')
    assert_nil metadata.title
  end

  test "meta description" do
    metadata = Metadata.new('<meta name="description" content="My Description">')
    assert_equal 'My Description', metadata.description
  end

  test "missing meta description" do
    metadata = Metadata.new('')
    assert_nil metadata.description
  end

  test "meta image" do
    metadata = Metadata.new('<meta property="og:image" content="http://example.com/image.jpg">')
    assert_equal 'http://example.com/image.jpg', metadata.image
  end

  test "missing meta image" do
    metadata = Metadata.new('')
    assert_nil metadata.image
  end
end