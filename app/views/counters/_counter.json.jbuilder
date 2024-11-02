# frozen_string_literal: true

json.extract! counter, :id, :name, :number, :created_at, :updated_at
json.url counter_url(counter, format: :json)
