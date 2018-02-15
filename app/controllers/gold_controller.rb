class GoldController < ApplicationController
    def index
        if session[:total_gold].nil?
            session[:total_gold] = 0
        end    
        if session[:messages].nil?
            session[:messages] = []
        end
        @t = Time.now.in_time_zone("Pacific Time (US & Canada)").strftime("%A, %B %d, %Y | %I:%M %p")
    end

    def find_gold
        gold_val = 0
        total_gold = session[:total_gold]
        session[:location] = params[:location]

        case params[:location]
            when "farm"
                then gold_val = random_gold(10, 20)
                message ={:text => "Earned #{gold_val} golds from the Casino.", :class => "green"}
            when "cave"
                then gold_val = random_gold(5, 10)
                message ={:text => "Earned #{gold_val} golds from the Casino.", :class => "green"}
            when "house"
                then gold_val = random_gold(2, 5)
                flash[:success]= "Earned #{gold_val} golds from the House."  
                message ={:text => "Earned #{gold_val} golds from the Casino.", :class => "green"}   
            when "casino"
                then gold_val = random_gold(-50, 50)
                    if gold_val < -1 
                        message ={:text => "Lost #{gold_val} golds to the Casino.", :class => "red"}
                    elsif gold_val == -1 
                        message ={:text => "Lost #{gold_val} golds to the Casino.", :class => "red"}  
                    elsif gold_val == 0 
                        message ={:text => "Earned nothing from the Casino.", :class => "grey"}
                    elsif gold_val == 1 
                        message ={:text => "Earned #{gold_val} gold from the Casino.", :class => "green"}
                    else  
                        message ={:text => "Earned #{gold_val} golds from the Casino.", :class => "green"}
                    end                         
        end 

        total_gold = total_gold + gold_val
        session[:total_gold] = total_gold
        session[:messages] = session[:messages].push(message)
       
        redirect_to '/'
    end

    def reset
        session.clear
        redirect_to '/'
    end    

    private
        def random_gold(min, max)
            rand(max - min) + min
        end
        
end
