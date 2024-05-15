class UserSerializer
  include FastVersionedSerializer

  attributes :email, :name, :archived_at, :is_archived

  set_type :users
end
