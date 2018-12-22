require 'test_helper'

class SeedTest < Minitest::Test
  def test_if_seed_is_properly_generated
    seed = Tangled::Seed.generate
    assert_equal seed.size, 81

    seed2 = Tangled::Seed.generate
    assert seed != seed2
  end
end
