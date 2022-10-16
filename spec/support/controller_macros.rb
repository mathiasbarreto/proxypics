module ControllerMacros
  def login_requester
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:requester]
      sign_in FactoryBot.create(:requester) # Using factory bot as an example
    end
  end

  def login_assignee
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:assigne]
      assigne = FactoryBot.create(:assigne)
      assigne.confirm! # or set a confirmed_at inside the factory. Only necessary if you are using the "confirmable" module
      sign_in assigne
    end
  end
end