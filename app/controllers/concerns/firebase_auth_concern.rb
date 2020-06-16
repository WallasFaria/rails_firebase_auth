# frozen_string_literal: true
require 'open-uri'

module FirebaseAuthConcern
  protected

  def authenticate_user!
    head 401 unless current_user.present?
  end

  def current_user
    @current_user ||= (find_user || create_user if firebase_user.present?)
  end

  private

  def firebase_user
    @firebase_user ||= FirebaseIdToken::Signature.verify(request.headers[:token])
  end

  def find_user
    User.find_by(auth_id: firebase_user['user_id'])
  end

  def create_user
    user = User.create(
      auth_id: firebase_user['user_id'],
      auth_provider: firebase_user['firebase']['sign_in_provider'],
      phone: firebase_user['phone_number'],
      name: firebase_user['name'],
      email: firebase_user['email']
    )

    if firebase_user['picture']
      file = open(firebase_user['picture'])
      user.avatar.attach(io: file, filename: user.auth_id, content_type: file.content_type)
    end

    user
  end
end
