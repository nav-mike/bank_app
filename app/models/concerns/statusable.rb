module Statusable
  extend ActiveSupport::Concern

  included do
    enum status: { active: 0, archived: 1 }
  end

  # TODO: override destroy/delete methods to prevent deletion
end
