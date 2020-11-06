require 'test_helper'

class TransactionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @transaction = transactions(:one)
  end

  test "should get index" do
    get transactions_url
    assert_response :success
  end

  test "should get new" do
    get new_transaction_url
    assert_response :success
  end

  test "should create transaction" do
    assert_difference('Transaction.count') do
      post transactions_url, params: { transaction: { amount: @transaction.amount, award_id: @transaction.award_id, card_email: @transaction.card_email, card_name: @transaction.card_name, category_id: @transaction.category_id, customer_netowrk: @transaction.customer_netowrk, customer_number: @transaction.customer_number, merchant_id: @transaction.merchant_id, nominee_id: @transaction.nominee_id, pay_status: @transaction.pay_status, payment_types: @transaction.payment_types, reference: @transaction.reference, techo_msg: @transaction.techo_msg, trans_id: @transaction.trans_id, trans_type: @transaction.trans_type } }
    end

    assert_redirected_to transaction_url(Transaction.last)
  end

  test "should show transaction" do
    get transaction_url(@transaction)
    assert_response :success
  end

  test "should get edit" do
    get edit_transaction_url(@transaction)
    assert_response :success
  end

  test "should update transaction" do
    patch transaction_url(@transaction), params: { transaction: { amount: @transaction.amount, award_id: @transaction.award_id, card_email: @transaction.card_email, card_name: @transaction.card_name, category_id: @transaction.category_id, customer_netowrk: @transaction.customer_netowrk, customer_number: @transaction.customer_number, merchant_id: @transaction.merchant_id, nominee_id: @transaction.nominee_id, pay_status: @transaction.pay_status, payment_types: @transaction.payment_types, reference: @transaction.reference, techo_msg: @transaction.techo_msg, trans_id: @transaction.trans_id, trans_type: @transaction.trans_type } }
    assert_redirected_to transaction_url(@transaction)
  end

  test "should destroy transaction" do
    assert_difference('Transaction.count', -1) do
      delete transaction_url(@transaction)
    end

    assert_redirected_to transactions_url
  end
end
