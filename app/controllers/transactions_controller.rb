class TransactionsController < ApplicationController
  before_action :set_transaction, only: [:show, :edit, :update, :destroy]
  
  require 'json'
  require 'faraday'
  require 'openssl'
  require 'uri'
  require 'net/http'
  require "base64"
  require 'twilio-ruby'

  # GET /transactions
  # GET /transactions.json
  def index
    @transactions = Transaction.all
  end

  # GET /transactions/1
  # GET /transactions/1.json
  def show
  end

  # GET /transactions/new
  def new
    @transaction = Transaction.new
  end

  # GET /transactions/1/edit
  def edit
  end
  
  
  
  
  def update_status(trans_ref,field,techo_status,techo_code,techo_reason)
      
      mon = Transaction.where(trans_id: trans_ref)[0]
      if mon != nil
          if field == "success"
              mon.pay_status = 1
              mon.techo_status = techo_status
              mon.techo_code = techo_code
              mon.techo_reason = techo_reason
              mon.save
              
              elsif field == "failure"
              mon.pay_status = 0
              mon.techo_status = techo_status
              mon.techo_code = techo_code
              mon.techo_reason = techo_reason
              mon.save
          end
          else
          puts
          puts
          
          puts "NO TRANSACTION ID MATCH WAS FOUND"
          puts "NO TRANSACTION ID MATCH WAS FOUND"
          puts "NO TRANSACTION ID MATCH WAS FOUND"
          puts "NO TRANSACTION ID MATCH WAS FOUND"
          puts "NO TRANSACTION ID MATCH WAS FOUND"
          puts
          puts
          puts
      end
      
  end
  
  
  
  
  CTRYCODE = '233'.freeze
  CTRYCODES = '+'.freeze
  
  def validatePhoneNumber(mobile_number)
      wildcard_search = "#{mobile_number}"
      if wildcard_search[0..2]=='233' && wildcard_search.length==12
          wildcard_search=CTRYCODE+"#{wildcard_search[3..wildcard_search.length]}"
          elsif wildcard_search[0]=='0' && wildcard_search.length==10
          wildcard_search = CTRYCODE+"#{wildcard_search[1..wildcard_search.length]}"
          elsif wildcard_search[0] == '+' && wildcard_search[1..3] == '233'&& wildcard_search[4..wildcard_search.length].length == 9
          wildcard_search = CTRYCODE+"#{wildcard_search[4..wildcard_search.length]}"
          elsif wildcard_search[0] != "+" && wildcard_search[0..2]!='233' && wildcard_search.length == 9
          wildcard_search=CTRYCODE+"#{wildcard_search[0..wildcard_search.length]}"
          
          elsif wildcard_search[0..1]=='00'
          wildcard_search=CTRYCODES+"#{wildcard_search[2..wildcard_search.length]}"
      end
      
      return wildcard_search
  end

  
  
  
  STR_API_KEY = "Rayke6KQIRGGcTQx9LtbYV8VC"
  MNOTIFY_URL = 'https://apps.mnotify.net'.freeze
  HEADER = { 'Content-Type' => 'Application/json', 'timeout' => '180', 'accept' => 'application/json' }.freeze
  CONNS = Faraday.new(url: MNOTIFY_URL, headers: HEADER) do |f|
  f.response :logger
  f.adapter Faraday.default_adapter
end

  
  
  def sendmsg(mobile_number,message_body,sender_identifier)
      
      
      
      resp_check = CONNS.get do |t|
          t.url "/smsapi?key=#{STR_API_KEY.to_s}&to=#{mobile_number.to_s}&msg=#{message_body}&sender_id=#{sender_identifier}"
      end
      
      
      
      puts "-----API RESPONSE------"
      puts resp_check.body
      puts
      
      
      
      resp_check.body
      
      
      
      
      
      
#      account_sid = 'AC6d745d2acd914afce9e13a8b031a8342'
#      auth_token = '98bacd8a47fe63c8bff123a148b6d5fa'
#      @client = Twilio::REST::Client.new(account_sid, auth_token)
#
#      from = 'VoteDigital' # Your Twilio number
#      to = phone # Your mobile phone number
#      @client.messages.create(
#                              from: from,
#                              to: to,
#                              body: msg
#                              )

                              
  end
  

  
  
  
  APIKEY = "MTQwODBiMjU3Yzg1ODhhYmIwM2Q5ZmFmYWVlNjJkOWQ="
  REQHDR = {'Content-Type'=>'application/json','Cache-Control'=>'no-cache'}
  MOMOPAY = "000200"
  MERCHID = "TTM-00000727"
  CARDPAY = "000000"
  

  
########## MOBILE MONEY REQUEST ######################################
  
  def mobileMoneyReq(merchant_id,transaction_id,amount,processing_code,switch,desc,subscriber_number,api_key,voucher_code,nominee_user)
      
      
      
      url = 'https://prod.theteller.net'
      url_endpoint = '/v1.1/transaction/process'
      conn = Faraday.new(url: url, headers: REQHDR, :ssl => {:verify => false}) do |f|
          f.response :logger
          f.adapter Faraday.default_adapter
      end
      
      
     
      logger.info "######## momo payment##############"
      logger.info "######## momo payment##############"
      logger.info "######## momo payment##############"
      logger.info "######## momo payment##############"
      payload={
          "amount" => amount,
          "processing_code" => processing_code,
          "transaction_id" => transaction_id,
          "desc" => desc,
          "merchant_id" => merchant_id,
          "subscriber_number" => subscriber_number,
          "r-switch" =>switch,
          "voucher_code" => voucher_code
         }
      
      logger.info "---Json Payload----"
      logger.info "---Json Payload----"
      
      json_payload=JSON.generate(payload)
      msg_endpoint="#{json_payload}"
      
      logger.info "JSON payload: #{json_payload.inspect}"
      

      begin
          resp = conn.post do |req|
              logger.info "----request--------"
              req.url url_endpoint
              logger.info url_endpoint
              req.options.timeout = 60           # open/read timeout in seconds
              req.options.open_timeout = 60      # connection open timeout in seconds
              req.headers["Authorization"] = "Basic cmFkNWQ0YTgxZDZhMzQ1MzpNVFF3T0RCaU1qVTNZemcxT0RoaFltSXdNMlE1Wm1GbVlXVmxOakprT1dRPQ=="
             
             
              req.body = json_payload
          end
          
          logger.info resp.inspect
          
         
          
          bidy = resp.body
            logger.info "---Request Body----"
            logger.info "---Request Body----"
            logger.info bidy.inspect
            logger.info resp
            logger.info resp.body
            logger.info "---Request Body----"
            logger.info "---Request Body----"
            logger.info "---Request Body----"
            logger.info "---Request Body----"
            logger.info "---Request Body----"
            logger.info "Result from theteller : #{resp.body}"
            logger.info "Status from theteller : #{resp.status}"
            
            if resp.status.to_s == "200"
                puts
                puts "Beta"
                puts
                
                
                
                
                result = JSON.parse resp.body
                
                logger.info "------Respones hash values-------"
                logger.info "------Respones hash values-------"
                logger.info "------Respones hash values-------"
                logger.info "------Respones hash values-------"
                
                logger.info status = result["status"]
                logger.info code = result["code"]
                logger.info reason = result["reason"]
                logger.info transaction_id = result["transaction_id"]
                
                  if code.to_s == "000"
                      
                      update_status(transaction_id,"success",status,code,reason)
                      
                      #send sms
                      phone_numbers = validatePhoneNumber(subscriber_number)
                      message = "Your VoteDigital Payment for #{nominee_user} was Successful"
                      puts message.inspect
                      puts sendmsg(phone_numbers,message,"VoteDigital")
                      
                      respond_to do |format|
                          
                          format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} #{reason}" }
                          format.json { head :no_content }
                      
                        end
                     
                  elsif code.to_s == "100"
                  
                  
                    update_status(transaction_id,"failure",status,code,reason)
                  
                     respond_to do |format|
                      
                      format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} #{reason}" }
                      format.json { head :no_content }
                      
                    end
                     
                    else
                    
                    respond_to do |format|
                        
                        format.html { redirect_to root_path, notice: "#{reason}" }
                        format.json { head :no_content }
                        
                    end
                  
                  
                 end
              
            end
            
            
                  
            
            
          
          #resp.body
          rescue Faraday::SSLError
          logger.info "SSL ERRor error"
          logger.info "SSL ERRor error"
          logger.info "SSL ERRor error"
          logger.info "SSL ERRor error"
          
          rescue Faraday::TimeoutError
          logger.info "Connection timeout error"
          logger.info "Connection timeout error"
          logger.info "Connection timeout error"
          
          respond_to do |format|
              
              format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} Session Expired, Kindly authorize payment on time" }
              format.json { head :no_content }
              
          end
          
          
          end
      
  end
  
  ########## MOBILE MONEY REQUEST ######################################
          
          
#          def ticketCode
#           token = rand(999999999999).to_s.center(12, rand(9).to_s)
#          end


def checkout_visa(transaction_id,merchant_id,amount,card_email,desc)
    url = 'https://prod.theteller.net'
    url_endpoint = '/checkout/initiate'
    conn = Faraday.new(url: url, headers: REQHDR, :ssl => {:verify => false}) do |f|
        f.response :logger
        f.adapter Faraday.default_adapter
    end
    
    logger.info "######## visa and master card payment##############"
    logger.info "######## visa and master card payment##############"
    logger.info "######## visa and master card payment##############"
    
    payload={
        "merchant_id" => merchant_id,
        "transaction_id" => transaction_id,
        "desc" => desc,
        "amount" => amount,
        "redirect_url"=>"https://votedigital.net/visa_callback",
        "email" => card_email
    }
    
    
    logger.info "---Json Payload----"
    logger.info "---Json Payload----"
    
    json_payload=JSON.generate(payload)
    msg_endpoint="#{json_payload}"
    
    logger.info "JSON payload: #{json_payload.inspect}"
    
    
    begin
        resp = conn.post do |req|
            logger.info "----request--------"
            req.url url_endpoint
            logger.info url_endpoint
            req.options.timeout = 60           # open/read timeout in seconds
            req.options.open_timeout = 60      # connection open timeout in seconds
            req.headers["Authorization"] = "Basic cmFkNWQ0YTgxZDZhMzQ1MzpNVFF3T0RCaU1qVTNZemcxT0RoaFltSXdNMlE1Wm1GbVlXVmxOakprT1dRPQ=="
            
            
            req.body = json_payload
        end
        
        puts resp
        
        bidy = resp.body
        puts "---Request Body----"
        puts "---Request Body----"
        puts bidy
        #puts bidy.code
        #puts resp.body
        puts "---Request Body----"
        puts "---Request Body----"
        puts "---Request Body----"
        puts "---Request Body----"
        puts "---Request Body----"
        #puts "Result from theteller : #{resp.body}"
        #puts "Status from theteller : #{resp.status}"
        
        
        
        #if resp.status.to_s == "200"
            puts
            puts "Beta"
            puts
            
            
            
            #puts result = JSON.parse resp.body
            #puts resp.body
            
            #puts result = JSON.parse bidy
            
            puts result = JSON.parse(bidy)
            puts url = result["checkout_url"]
            puts code = result["code"]
            puts reason = result["reason"]
            
            
            puts "------Respones hash values-------"
            puts "------Respones hash values-------"
            puts "------Respones hash values-------"
            puts "------Respones hash values-------"
            
            if code.to_s == "200"
                respond_to do |format|
                    format.html { redirect_to url, notice: "#{reason}" }
                    format.json { head :no_content }
                
                end
                
              else
              
              respond_to do |format|
                  
                 format.html { redirect_to root_path, notice: "#{reason}" }
                 format.json { head :no_content }
                  
                end
            
                
            end
            
            #puts status = result.status
            #puts url = result.checkout_url
            #puts code = result["code"]
            #puts reason = result["reason"]
            #puts transaction_id = result["checkout_url"]
            
            
            
            #if code.to_s == "200"
                
#                update_status(transaction_id,"success",status,code,reason)
#
#                respond_to do |format|
#
#                    format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} #{reason}" }
#                    format.json { head :no_content }
#
#                end

#elsif code.to_s == "100"
                
                
#                update_status(transaction_id,"failure",status,code,reason)
#
#                respond_to do |format|
#
#                    format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} #{reason}" }
#                    format.json { head :no_content }
#
#                end
#
# else
                
#                respond_to do |format|
#
#                    format.html { redirect_to root_path, notice: "#{reason}" }
#                    format.json { head :no_content }
#
#                end

                
                #end
            
            #end
        
        
        
        
        
        
        #resp.body
        rescue Faraday::SSLError
        puts "SSL ERRor error"
        puts "SSL ERRor error"
        puts "SSL ERRor error"
        puts "SSL ERRor error"
        
        rescue Faraday::TimeoutError
        puts "Connection timeout error"
        puts "Connection timeout error"
        puts "Connection timeout error"
        
#        respond_to do |format|
#
#            format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} Session Expired, Kindly authorize payment on time" }
#            format.json { head :no_content }
#
#        end

        
    end
    
    
    
    
    
end


############ VISA/MASTER CARD ###########################################
def visa_master(processing_code,switch,transaction_id,merchant_id,card_number,card_exp_month,card_exp_year,card_cvv,desc,amount,card_name,card_email,nominee_user)
    
    url = 'https://prod.theteller.net'
    url_endpoint = '/v1.1/transaction/process'
    conn = Faraday.new(url: url, headers: REQHDR, :ssl => {:verify => false}) do |f|
        f.response :logger
        f.adapter Faraday.default_adapter
    end
    
    
    logger.info "######## visa and master card payment##############"
    logger.info "######## visa and master card payment##############"
    logger.info "######## visa and master card payment##############"
    logger.info "######## visa and master card payment##############"
    payload={
        "processing_code" => processing_code,
        "r-switch" => switch,
        "transaction_id" => transaction_id,
        "merchant_id" => merchant_id,
        "pan" => card_number,
        "3d_url_response" => "http://74.207.231.185:3010/",
        "exp_month" => card_exp_month,
        "exp_year" => card_exp_year,
        "cvv" => card_cvv,
        "desc" => desc,
        "amount" => amount,
        "currency" => "GHS",
        "card_holder" => card_name,
        "customer_email" => card_email
         }
    
    
    
    logger.info "---Json Payload----"
    logger.info "---Json Payload----"
    
    json_payload=JSON.generate(payload)
    msg_endpoint="#{json_payload}"
    
    logger.info "JSON payload: #{json_payload.inspect}"
    
    
    
    begin
        resp = conn.post do |req|
            logger.info "----request--------"
            req.url url_endpoint
            logger.info url_endpoint
            req.options.timeout = 60           # open/read timeout in seconds
            req.options.open_timeout = 60      # connection open timeout in seconds
            req.headers["Authorization"] = "Basic cmFkNWQ0YTgxZDZhMzQ1MzpNVFF3T0RCaU1qVTNZemcxT0RoaFltSXdNMlE1Wm1GbVlXVmxOakprT1dRPQ=="
            
            
            req.body = json_payload
        end
        
        logger.info resp.inspect
        
        
        
        bidy = resp.body
        logger.info "---Request Body----"
        logger.info "---Request Body----"
        logger.info bidy.inspect
        logger.info resp
        logger.info resp.body
        logger.info "---Request Body----"
        logger.info "---Request Body----"
        logger.info "---Request Body----"
        logger.info "---Request Body----"
        logger.info "---Request Body----"
        logger.info "Result from theteller : #{resp.body}"
        logger.info "Status from theteller : #{resp.status}"
        
        if resp.status.to_s == "200"
            puts
            puts "Beta"
            puts
            
            
            
            result = JSON.parse resp.body
            
            logger.info "------Respones hash values-------"
            logger.info "------Respones hash values-------"
            logger.info "------Respones hash values-------"
            logger.info "------Respones hash values-------"
            
            logger.info status = result["status"]
            logger.info code = result["code"]
            logger.info reason = result["reason"]
            logger.info transaction_id = result["transaction_id"]
            
            if code.to_s == "000"
                
                update_status(transaction_id,"success",status,code,reason)
                
                respond_to do |format|
                    
                    format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} #{reason}" }
                    format.json { head :no_content }
                    
                end
                
                elsif code.to_s == "100"
                
                
                update_status(transaction_id,"failure",status,code,reason)
                
                respond_to do |format|
                    
                    format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} #{reason}" }
                    format.json { head :no_content }
                    
                end
                
                else
                
                respond_to do |format|
                    
                    format.html { redirect_to root_path, notice: "#{reason}" }
                    format.json { head :no_content }
                    
                end
                
                
            end
            
        end
        
        
        
        
        
        
        #resp.body
        rescue Faraday::SSLError
        logger.info "SSL ERRor error"
        logger.info "SSL ERRor error"
        logger.info "SSL ERRor error"
        logger.info "SSL ERRor error"
        
        rescue Faraday::TimeoutError
        logger.info "Connection timeout error"
        logger.info "Connection timeout error"
        logger.info "Connection timeout error"
        
        respond_to do |format|
            
            format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{nominee_user} Session Expired, Kindly authorize payment on time" }
            format.json { head :no_content }
            
        end
        
        
    end
    
    
    
    
    
    
    
end





######## END OF VISA/MASTER CARD #######################################




  def genUniqueCodeCredit
      time = Time.new
      strtm = time.strftime('%d%L%H%M')
      uniq_id = "109#{strtm}"
      uniq_id
  end
  
  def format_amount(amount)
  amt = (amount.round(2) * 100).to_i.to_s
  (amount.present? && amount > 0 && amt.length <= 12) ? "%012d" % amt : "000000000000"
  end
  
  
  def payme_user
      @nom_id = params[:id].to_i
      @mobile_number = transaction_params[:customer_number]
      @net = transaction_params[:customer_netowrk]
      @p_type = transaction_params[:payment_types]
      @v_oucher_code = transaction_params[:voucher]
      @no_of_votes = transaction_params[:vote_no_mm]
      
      logger.info "The nominee Id is  #{@nom_id.inspect}"
      logger.info "The mobile number is #{@mobile_number.inspect}"
      logger.info "The network is #{@net.inspect}"
      logger.info "The payment type is #{@p_type.inspect}"
      logger.info "the voucher code is #{@v_oucher_code.inspect}"
      logger.info "the number of votes is #{@no_of_votes.inspect}"
      logger.info "transaction params is #{transaction_params.inspect}"
      

      
      if @p_type == "1"
         logger.info "----mobile money--------"
           u_code = genUniqueCodeCredit
           
           logger.info "transaction code"
           logger.info "transaction code"
           logger.info "transaction code"
         
           logger.info u_code.inspect
           
           
           vote_nom = Nominee.where(id: @nom_id)[0]
           cat_id = vote_nom.category_id
           nominee_user = vote_nom.name
         logger.info "---category------"
         vote_cat = Category.where(id: cat_id)[0]
         awd_id = vote_cat.award_id
         vote_award = Award.where(id: awd_id)[0]
         awd_amount = vote_award.award_amount
         mrh = vote_award.merchant_id
         merch = Merchant.where(id: mrh)[0]
         amounts = (awd_amount.to_f * @no_of_votes.to_f)
         _amounts = amounts.round(2)
         
         _format_amt = format_amount(_amounts)
         
         
          logger.info "The category Id is  #{cat_id.inspect}"
          logger.info "The award Id is  #{awd_id.inspect}"
          logger.info "The merchant Id is  #{mrh.inspect}"
          logger.info "The award amount is  #{awd_amount.inspect}"
          logger.info "The amount is  #{_amounts.inspect}"
          logger.info "The _format_amt is  #{_format_amt.inspect}"
          
          
          @create_trans = Transaction.create!(
             merchant_id: mrh,
             trans_id: u_code,
             customer_number: @mobile_number,
             customer_netowrk: @net,
             trans_type: "DR",
             amount: _amounts,
             reference: "Web(VoteDigital)",
             pay_status: false,
             award_id: awd_id,
            category_id: cat_id,
            nominee_id: @nom_id,
            payment_types: @p_type,
            vote_no_mm: @no_of_votes
                                              
          )
         
         
         if @net == "VDF"
             voucher_code = @v_oucher_code
             else
             voucher_code = ""
         end
         desc = "VoteDigital payment for #{nominee_user},Kindly authorize payment."
         
         
         if @net == "VDF"
             
             respond_to do |format|
                 
                 format.html { redirect_to root_path, notice: "Your Transaction has being Processed" }
                 format.json { head :no_content }
                 
             end
             
          else
          
          respond_to do |format|
              
              format.html { redirect_to root_path, notice: "Kindly Authorize payment for #{nominee_user} on your Phone" }
              format.json { head :no_content }
              
          end
         
         end
         
         
         Thread.new do
             sleep 1
         logger.info mobileMoneyReq(MERCHID,u_code,_format_amt,MOMOPAY,@net,desc,@mobile_number,APIKEY,voucher_code,nominee_user)
         
          end
         
         
         
elsif @p_type == "2"
 logger.info "----visa payments--------"
     @nom_id = params[:id].to_i
     @p_type = transaction_params[:payment_types]
     @no_of_votes = transaction_params[:vote_no_card]
     @card_name = transaction_params[:card_name]
     @card_email = transaction_params[:card_email]
     @card_number = transaction_params[:card_number]
     @cvv_code = transaction_params[:cvv_code]
     @card_month = transaction_params[:card_month]
     @card_year = transaction_params[:card_year]
     
     logger.info "The nominee Id is  #{@nom_id.inspect}"
     logger.info "The p_type is #{@p_type.inspect}"
     logger.info "The no_of_votes is #{@no_of_votes.inspect}"
     logger.info "The card_name is #{@card_name.inspect}"
     logger.info "the card_email is #{@card_email.inspect}"
     logger.info "the card_number is #{@card_number.inspect}"
     logger.info "cvv_code is #{@cvv_code.inspect}"
     logger.info "card_month is #{@card_month.inspect}"
     logger.info "card_year is #{@card_year.inspect}"
     
     u_code = genUniqueCodeCredit
     
     logger.info "transaction code"
     logger.info "transaction code"
     logger.info "transaction code"
     
     logger.info u_code.inspect
     
     
     vote_nom = Nominee.where(id: @nom_id)[0]
     cat_id = vote_nom.category_id
     nominee_user = vote_nom.name
     logger.info "---category------"
     vote_cat = Category.where(id: cat_id)[0]
     awd_id = vote_cat.award_id
     vote_award = Award.where(id: awd_id)[0]
     awd_amount = vote_award.award_amount
     mrh = vote_award.merchant_id
     merch = Merchant.where(id: mrh)[0]
     amounts = (awd_amount.to_f * @no_of_votes.to_f)
     _amounts = amounts.round(2)
     
      _format_amt = format_amount(_amounts)
     
     
     logger.info "The category Id is  #{cat_id.inspect}"
     logger.info "The award Id is  #{awd_id.inspect}"
     logger.info "The merchant Id is  #{mrh.inspect}"
     logger.info "The award amount is  #{awd_amount.inspect}"
     logger.info "The amount is  #{_amounts.inspect}"
     logger.info "The _format_amt is  #{_format_amt.inspect}"
     
     
     @create_trans = Transaction.create!(
                        merchant_id: mrh,
                        trans_id: u_code,
                        card_email: @card_email,
                        card_name: @card_name,
                        trans_type: "VIS",
                        amount: _amounts,
                        reference: "Web(VoteDigital)",
                        pay_status: false,
                        award_id: awd_id,
                        category_id: cat_id,
                        nominee_id: @nom_id,
                        payment_types: @p_type,
                        vote_no_mm: @no_of_votes
                        )
                        
               desc = "VoteDigital payment for #{nominee_user},Kindly authorize payment."
               
    checkout_visa(u_code,MERCHID,_format_amt,@card_email,desc)
    #visa_master(CARDPAY,"VIS",u_code,MERCHID,@card_number,@card_month,@card_year,@cvv_code,desc,_format_amt,@card_name,@card_email,nominee_user)
        
        
        
    elsif @p_type == "3"
       logger.info "----MASTER CARD payments--------"
       
       @nom_id = params[:id].to_i
       @p_type = transaction_params[:payment_types]
       @no_of_votes = transaction_params[:vote_no_card1]
       @card_name = transaction_params[:card_name]
       @card_email = transaction_params[:card_email]
       @card_number = transaction_params[:card_number]
       @cvv_code = transaction_params[:cvv_code]
       @card_month = transaction_params[:card_month]
       @card_year = transaction_params[:card_year]
       
       logger.info "The nominee Id is  #{@nom_id.inspect}"
       logger.info "The p_type is #{@p_type.inspect}"
       logger.info "The no_of_votes is #{@no_of_votes.inspect}"
       logger.info "The card_name is #{@card_name.inspect}"
       logger.info "the card_email is #{@card_email.inspect}"
       logger.info "the card_number is #{@card_number.inspect}"
       logger.info "cvv_code is #{@cvv_code.inspect}"
       logger.info "card_month is #{@card_month.inspect}"
       logger.info "card_year is #{@card_year.inspect}"
       
       u_code = genUniqueCodeCredit
       
       logger.info "transaction code"
       logger.info "transaction code"
       logger.info "transaction code"
       
       logger.info u_code.inspect
       
       
       vote_nom = Nominee.where(id: @nom_id)[0]
       cat_id = vote_nom.category_id
       nominee_user = vote_nom.name
       logger.info "---category------"
       vote_cat = Category.where(id: cat_id)[0]
       awd_id = vote_cat.award_id
       vote_award = Award.where(id: awd_id)[0]
       awd_amount = vote_award.award_amount
       mrh = vote_award.merchant_id
       merch = Merchant.where(id: mrh)[0]
       amounts = (awd_amount.to_f * @no_of_votes.to_f)
       _amounts = amounts.round(2)
       
        _format_amt = format_amount(_amounts)
       
       logger.info "The category Id is  #{cat_id.inspect}"
       logger.info "The award Id is  #{awd_id.inspect}"
       logger.info "The merchant Id is  #{mrh.inspect}"
       logger.info "The award amount is  #{awd_amount.inspect}"
       logger.info "The amount is  #{_amounts.inspect}"
       logger.info "The _format_amt is  #{_format_amt.inspect}"
       
       
       @create_trans = Transaction.create!(
                         merchant_id: mrh,
                         trans_id: u_code,
                         card_email: @card_email,
                         card_name: @card_name,
                         trans_type: "MAS",
                         amount: _amounts,
                         reference: "Web(VoteDigital)",
                         pay_status: false,
                         award_id: awd_id,
                         category_id: cat_id,
                         nominee_id: @nom_id,
                         payment_types: @p_type,
                         vote_no_mm: @no_of_votes
                            )
                                           
        desc = "VoteDigital payment for #{nominee_user},Kindly authorize payment."
                                           
                                           
visa_master(CARDPAY,"MAS",u_code,MERCHID,@card_number,@card_month,@card_year,@cvv_code,desc,_format_amt,@card_name,@card_email,nominee_user)
                                           
        
        
        
      end
      
      
  end
  
  
  
  
  

  # POST /transactions
  # POST /transactions.json
  def create
    @transaction = Transaction.new(transaction_params)

    respond_to do |format|
      if @transaction.save
        format.html { redirect_to @transaction, notice: 'Transaction was successfully created.' }
        format.json { render :show, status: :created, location: @transaction }
      else
        format.html { render :new }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /transactions/1
  # PATCH/PUT /transactions/1.json
  def update
    respond_to do |format|
      if @transaction.update(transaction_params)
        format.html { redirect_to @transaction, notice: 'Transaction was successfully updated.' }
        format.json { render :show, status: :ok, location: @transaction }
      else
        format.html { render :edit }
        format.json { render json: @transaction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /transactions/1
  # DELETE /transactions/1.json
  def destroy
    @transaction.destroy
    respond_to do |format|
      format.html { redirect_to transactions_url, notice: 'Transaction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_transaction
      @transaction = Transaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def transaction_params
        params.require(:transaction).permit(:merchant_id, :trans_id, :customer_number, :customer_netowrk, :trans_type, :amount, :reference, :pay_status, :award_id, :category_id, :nominee_id,:payment_types, :card_name, :card_email,:voucher,:techo_status,:techo_code,:techo_reason,:vote_no_mm,:vote_no_card,:card_number,:cvv_code,:card_month,:card_year,:vote_no_card1,:card_name1,:card_email1,:card_number1,:cvv_code1,:card_month1,:card_year1)
    end
end


