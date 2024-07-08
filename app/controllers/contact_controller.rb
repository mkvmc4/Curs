class ContactController < ApplicationController
    
    def follow
     @heading = 'Our contacts for communication and ordering a table'
     @text = '+38097853125 
     Assist.gmail.com'
                       
    end
end
