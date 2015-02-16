require "minitest_helper"

def app
    Rails.application
end



describe "API Widget integration" do 


    it "shoudld" do 

                widget_creation_count = 22

                (1..widget_creation_count).each do 
                    FactoryGirl.create(:widget)
                end

                get '/api/widgets'
                assert last_response.successful?
                assert last_response_json['widgets'].count.must_equal widget_creation_count


    end




end


