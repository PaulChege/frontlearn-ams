# frozen_string_literal: true

class CreateFirstAdmin
  def self.invoke
    user = User.new(
      email: 'admin@frontlearn.co.ke',
      full_name: 'Frontlearn Admin',
      role: :admin,
      password: 'frontlearn16'
    )
    user.save! if user.valid?
  end
end
