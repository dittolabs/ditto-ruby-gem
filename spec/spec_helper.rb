require "support/helpers/response_helper"
require "support/helpers/sample_data_helper"

RSpec.configure do |config|
  config.disable_monkey_patching!

  config.order = :random
  Kernel.srand(config.seed)
end
