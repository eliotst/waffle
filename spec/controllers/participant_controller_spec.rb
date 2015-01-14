require 'spec_helper'

describe ParticipantsController, type: :controller do
  before(:each) do
    @admin_user = create(:admin)
    @regular_user = create(:user)
  end
end
