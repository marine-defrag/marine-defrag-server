class MembershipSerializer
  include FastApplicationSerializer

  attributes :member_id, :memberof_id, :created_by_id

  set_type :memberships
end
