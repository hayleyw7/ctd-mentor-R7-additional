RSpec.configure do |config|
  config.before(:each, type: :system) do
    page.evaluate_script('window.confirm = function() { return true; }')
  end
end
