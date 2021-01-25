# frozen_string_literal: true
require 'open-uri'

module FirebaseAuthConcern
  include ActionController::HttpAuthentication::Token::ControllerMethods

  protected

  def authenticate_user!
    head 401 unless current_user.present?
  end

  def current_user
    @current_user ||= (find_user || create_user if firebase_user.present?)
  end

  private

  def firebase_user
    authenticate_with_http_token do |token|
      @firebase_user ||= FirebaseIdToken::Signature.verify(token)
    end
  end

  def find_user
    User.find_by(auth_id: firebase_user['user_id'])
  end

  def create_user
    User.create(
      auth_id: firebase_user['user_id'],
      auth_provider: firebase_user['firebase']['sign_in_provider'],
      phone: firebase_user['phone_number'],
      name: firebase_user['name'],
      email: firebase_user['email'],
      avatar: user_avatar
    )
  end

  def user_avatar
    return unless firebase_user['picture']

    file = open(firebase_user['picture'])
    ActiveStorage::Blob.build_after_upload(
      io: file,
      filename: firebase_user['user_id'],
      content_type: file.content_type
    )
  end
end
