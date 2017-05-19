require 'support/active_record_environment'

RSpec.describe Machinist::ActiveRecord do
  include ActiveRecordEnvironment

  before do
    empty_database!
  end

  context 'make' do
    it 'returns an unsaved object' do
      Post.blueprint {}
      post = Post.make
      expect(post).to be_a(Post)
      expect(post).to be_new_record
    end
  end

  context 'make!' do
    it 'makes and saves objects' do
      Post.blueprint {}
      post = Post.make!
      expect(post).to be_a(Post)
      expect(post).not_to be_new_record
    end

    it 'raises an exception for an invalid object' do
      User.blueprint {}
      expect do
        User.make!(username: '')
      end.to raise_error(Machinist::BlueprintCantSaveError)
    end
  end

  context 'associations support' do
    it 'handles belongs_to associations' do
      User.blueprint do
        username { "user_#{sn}" }
      end
      Post.blueprint do
        author
      end
      post = Post.make!
      expect(post).to be_a(Post)
      expect(post).not_to be_new_record
      expect(post.author).to be_a(User)
      expect(post.author).not_to be_new_record
    end

    it 'handles has_many associations' do
      Post.blueprint do
        comments(3)
      end
      Comment.blueprint {}
      post = Post.make!
      expect(post).to be_a(Post)
      expect(post).not_to be_new_record
      expect(post.comments.size).to eq(3)
      post.comments.each do |comment|
        expect(comment).to be_a(Comment)
        expect(comment).not_to be_new_record
      end
    end

    it 'handles habtm associations' do
      Post.blueprint do
        tags(3)
      end
      Tag.blueprint do
        name { "tag_#{sn}" }
      end
      post = Post.make!
      expect(post).to be_a(Post)
      expect(post).not_to be_new_record
      expect(post.tags.size).to eq(3)
      post.tags.each do |tag|
        expect(tag).to be_a(Tag)
        expect(tag).not_to be_new_record
      end
    end

    it 'handles overriding associations' do
      User.blueprint do
        username { "user_#{sn}" }
      end
      Post.blueprint do
        author { User.make(username: "post_author_#{sn}") }
      end
      post = Post.make!
      expect(post).to be_a(Post)
      expect(post).not_to be_new_record
      expect(post.author).to be_a(User)
      expect(post.author).not_to be_new_record
      expect(post.author.username).to match(/^post_author_\d+$/)
    end
  end

  context 'error handling' do
    it 'raises an exception for an attribute with no value' do
      User.blueprint { username }
      expect do
        User.make
      end.to raise_error(ArgumentError)
    end
  end
end
