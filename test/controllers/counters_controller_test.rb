require "test_helper"

class CountersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    user.password = user.encrypted_password
    user.save
    sign_in user

    @counter = counters(:one)
    @counter.user_id = user.id
  end

  test "should get index" do
    get counters_url
    assert_response :success
  end

  test "should get new" do
    get new_counter_url
    assert_response :success
  end

  test "should create counter" do
    assert_difference("Counter.count") do
      post counters_url, params: { counter: { name: @counter.name, number: @counter.number } }
    end

    assert_redirected_to counter_url(Counter.last)
  end

  test "should show counter" do
    @counter.save
    get counter_url(@counter)
    assert_response :success
  end

  test "should get edit" do
    @counter.save
    get edit_counter_url(@counter)
    assert_response :success
  end

  test "should update counter" do
    @counter.save
    patch counter_url(@counter), params: { counter: { name: @counter.name, number: @counter.number } }
    assert_redirected_to counter_url(@counter)
  end

  test "should destroy counter" do
    @counter.save
    assert_difference("Counter.count", -1) do
      delete counter_url(@counter)
    end

    assert_redirected_to counters_url
  end

  test "should add 1 to counter" do
    @counter.save
    patch counter_url(@counter), params: { commit: "Up" }
    @counter.reload
    assert @counter.number == 1
    assert_redirected_to counters_url
  end

  test "should subtract 1 from counter" do
    @counter.save
    patch counter_url(@counter), params: { commit: "Down" }
    @counter.reload
    assert @counter.number == -1
    assert_redirected_to counters_url
  end

  test "should reset counter" do
    @counter.save
    patch counter_url(@counter), params: { commit: "Reset" }
    @counter.reload
    assert @counter.number == 0
    assert_redirected_to counters_url
  end
end
