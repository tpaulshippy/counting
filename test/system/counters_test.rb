# frozen_string_literal: true

require 'application_system_test_case'

class CountersTest < ApplicationSystemTestCase
  setup do
    @counter = counters(:one)

    @user = users(:one)

    sign_in @user
  end

  test 'visiting the index' do
    visit counters_url
    assert_selector 'h1', text: 'Counters'
  end

  test 'should create counter' do
    visit counters_url
    click_on 'New counter'

    fill_in 'Name', with: @counter.name
    fill_in 'Number', with: @counter.number
    click_on 'Create Counter'

    assert_text 'Counter was successfully created'
    click_on 'Back'
  end

  test 'should update Counter' do
    visit counter_url(@counter)
    click_on 'Edit this counter', match: :first

    fill_in 'Name', with: @counter.name
    fill_in 'Number', with: @counter.number
    click_on 'Update Counter'

    assert_text 'Counter was successfully updated'
    click_on 'Back'
  end

  test 'should destroy Counter' do
    visit counter_url(@counter)
    click_on 'Destroy this counter', match: :first

    assert_text 'Counter was successfully destroyed'
  end
end
