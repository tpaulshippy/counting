# frozen_string_literal: true

json.array! @counters, partial: 'counters/counter', as: :counter
