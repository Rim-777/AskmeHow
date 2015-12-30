require 'rails_helper'

describe CommentsController do

  let!(:user) { create(:user) }
  let!(:commentable_object) { create(:question, user: user) }
  let(:comment_params) do
    {comment: attributes_for(:comment),  commentable: 'question',   question_id: commentable_object.id  }
  end

  let(:invalid_params) do
    {comment: attributes_for(:invalid_comment),  commentable: 'question',   question_id: commentable_object.id  }
  end

  it_behaves_like "Comment"
end


describe CommentsController do

  let!(:user) { create(:user) }
  let!(:question) { create(:question, user: user) }
  let!(:commentable_object) { create(:answer, question: question, user: user) }

  let(:comment_params) do
    {comment: attributes_for(:comment),  commentable: 'answer',   answer_id: commentable_object.id  }
  end

  let(:invalid_params) do
    {comment: attributes_for(:invalid_comment),  commentable: 'answer',   answer_id: commentable_object.id  }
  end
  it_behaves_like "Comment"
end


