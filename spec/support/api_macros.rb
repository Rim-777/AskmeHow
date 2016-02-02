module ApiMacros

  def let_questions_spec_objects
    let(:user) { create (:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:questions_list) { create_list(:question, 2, user: user) }
    let!(:question) { questions_list.first }
    let!(:answer) { create(:answer, question_id: question.id, user: create(:user)) }
    let!(:attachment_list) { create_list(:attachment, 2, attachable: question) }
    let!(:attachment) { attachment_list.first }
    let!(:comment_list) { create_list(:comment, 2, commentable_id: question.id,
                                      commentable_type: question.class.to_s, user: create(:user)) }
    let!(:comment) { comment_list.first }
  end


  
  def let_answers_spec_objects
    let(:user) { create (:user) }
    let(:access_token) { create(:access_token, resource_owner_id: user.id) }
    let!(:question) { create(:question, user: create(:user)) }
    let!(:answer_list) { create_list(:answer, 3, question: question, user: user) }
    let!(:answer) { answer_list.first }
    let!(:attachment_list) { create_list(:attachment, 2, attachable: answer) }
    let!(:attachment) { attachment_list.first }
    let!(:comment_list) { create_list(:comment, 2, commentable_id: answer.id,
                                      commentable_type: answer.class.to_s, user: create(:user)) }
    let!(:comment) { comment_list.first }
  end
  
  


  def it_return_200_status
    it 'return 200 status' do
      expect(response).to be_success
    end

  end


    def do_request(method, path, options = {})
      send method, path, { format: :json }.merge(options)
    end


end