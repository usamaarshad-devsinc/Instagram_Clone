# frozen_string_literal: true

ThinkingSphinx::Index.define :account, with: :active_record do
  indexes email
  indexes username, sortable: true
  indexes full_name, sortable: true
  indexes [email, username, full_name], as: :account_info
end
