require "test_helper"

class CountersControllerTest < ActionDispatch::IntegrationTest
  setup do
    user = users(:one)
    user.password = user.encrypted_password
    user.save
    sign_in user

    @counter = counters(:one)
    @counter.user_id = user.id

    user2 = users(:two)
    user2.password = user2.encrypted_password
    user2.save

    @counter2 = counters(:two)
    @counter2.user_id = user2.id

    @shared_counter = counters(:shared)
    @shared_counter.user_id = user2.id
    @shared_counter.users << user
  end

  test "should get index" do
    @counter.save
    @counter2.save
    @shared_counter.save
    get counters_url
    assert_response :success
    assert_match "Counter1", @response.body
    assert_match "CounterShared", @response.body
    refute_match "Counter2", @response.body
  end

  test "should get new" do
    get new_counter_url
    assert_response :success
  end

  test "should create counter" do
    assert_difference("Counter.count") do
      post counters_url, params: { counter: { name: @counter.name, number: @counter.number } }
    end

    assert_redirected_to counters_url
  end

  test "should show counter" do
    @counter.save
    get counter_url(@counter)
    assert_response :success
  end

  
  test "should not show other user's counter" do
    @counter2.save
    get counter_url(@counter2)
    assert_response :not_found
  end


  test "should show shared counter" do
    @shared_counter.save
    get counter_url(@shared_counter)
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
    assert_redirected_to counters_url
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
    assert_response :success
  end

  test "should subtract 1 from counter" do
    @counter.save
    patch counter_url(@counter), params: { commit: "Down" }
    @counter.reload
    assert @counter.number == -1
    assert_response :success
  end

  test "should reset counter" do
    @counter.save
    patch counter_url(@counter), params: { commit: "Reset" }
    @counter.reload
    assert @counter.number == 0
    assert_response :success
  end
end
