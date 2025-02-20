class UserSerializer
  include FastVersionedSerializer

  attributes :email, :name, :is_archived

  set_type :users
end
