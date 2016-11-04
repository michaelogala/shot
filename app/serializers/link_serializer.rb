class LinkSerializer < ActiveModel::Serializer
  attributes :id, :slug, :clicks, :active
  attribute :given_url, key: :url
  attribute :created_at, key: :date_created
  attribute :updated_at, key: :date_updated
end
