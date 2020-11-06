class HomeController < ApplicationController
    skip_before_action :verify_authenticity_token
  require 'json'
  
  def dashboard
      
      if params[:per_page].present?
          if params[:per_page] == "All"
              @per_page = 10000000000000000
              else
              @per_page = params[:per_page]
          end
          else
          @per_page = 9
      end
      
      
    
    @awards = Award.where(status: true).paginate(:page => params[:page], :per_page => @per_page).order('created_at desc')
    
   
  	
  end
  
  def vote_category
  
  end
  
  def vote_nominee
      
  end
  
  def vote_pay
    @transaction = Transaction.new
    @paymentTypes = [['MobileMoney',"1"],['Visa',"2"]]
    @networks = [['Airtel','ATL'],['Mtn','MTN'],['Vodafone','VDF'],['Tigo','TGO']]
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
  
  
  
  
  
  def visa_callback
      puts "THIS IS MY VOTEDIGITAL VISA CALLBACK  CALLBACK"
      puts "THIS IS MY VOTEDIGITAL VISA CALLBACK  CALLBACK"
      puts "THIS IS MY VOTEDIGITAL VISA CALLBACK  CALLBACK"
      

       puts code = params["code"]
       puts status = params["status"]
       puts transaction_id = params["transaction_id"]
       puts reason = params["status"]
       
       if code.to_s == "000"
           puts "---------- successfully transactions----------"
           puts "---------- successfully transactions----------"
           puts "---------- successfully transactions----------"
           
           update_status(transaction_id,"success",status,code,reason)
           
          nom = Transaction.where(trans_id: transaction_id)[0]
          nom_name = Nominee.where(id: nom.nominee_id)[0]
          _name = nom_name.name
          
           
            respond_to do |format|
           
           format.html { redirect_to root_path, notice: "Your VoteDigital payment for #{_name} was #{reason}" }
               format.json { head :no_content }
           
           end
           
       else
       
       puts "---------- failed transactions----------"
       puts "---------- failed transactions----------"
       puts "---------- failed transactions----------"
       
       
       
        update_status(transaction_id,"failure",status,code,reason)
        
        nom = Transaction.where(trans_id: transaction_id)[0]
        nom_name = Nominee.where(id: nom.nominee_id)[0]
        _name = nom_name.name
        
        
        respond_to do |format|
            
            format.html { redirect_to root_path, notice: "Your VoteDigital payment for  #{_name} was #{reason}" }
            format.json { head :no_content }
            
        end
       
       
       end

   
      

  end
  
  

  def about

  end

  def contact

  end

  def Voting
  
 
  end
  
  
  def contact_us
      logger.info "----contact us----------"
      logger.info Contact.create!(
        fullname: params["fullname"],
        email: params["email"],subject: params["subject"],
        message: params["message"],status: true
                        
      )
    redirect_to root_path, notice: "Thank you for contacting us."

  end


end
