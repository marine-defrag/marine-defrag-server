class FeedbackSerializer
  include FastVersionedSerializer

  attributes :user_id, :subject, :content

  set_type :feedbacks
end
