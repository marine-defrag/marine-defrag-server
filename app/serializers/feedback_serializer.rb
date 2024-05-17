class FeedbackSerializer
  include FastApplicationSerializer

  attributes :user_id, :subject, :content

  set_type :feedbacks
end
