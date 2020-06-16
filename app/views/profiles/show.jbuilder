# frozen_string_literal: true

json.merge! @user.attributes

json.avatar_url @user.avatar.attached? ?
  rails_representation_url(@user.avatar.variant(resize_to_limit: [200, 200])) :
  nil
