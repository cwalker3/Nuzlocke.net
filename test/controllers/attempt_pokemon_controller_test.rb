require "test_helper"

class AttemptPokemonControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get attempt_pokemon_create_url
    assert_response :success
  end
end
