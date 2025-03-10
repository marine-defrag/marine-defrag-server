class PageSerializer
  include FastVersionedSerializer

  attributes :title, :content, :menu_title, :order, :draft, :document_url, :private

  set_type :pages
end
