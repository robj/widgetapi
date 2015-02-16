require "minitest_helper"

def app
    Rails.application
end



describe "API Widget integration" do 


    it "should list widgets index" do 

                widget_creation_count = 22

                (1..widget_creation_count).each do 
                    FactoryGirl.create(:widget)
                end

                get '/api/widgets'
                assert last_response.successful?
                assert last_response_json['widgets'].count.must_equal widget_creation_count


    end


    it "should get a widget with expected keys" do


        widget =  FactoryGirl.create(:widget)

        get "/api/widgets/#{widget.id}"
        assert last_response.successful?
        assert last_response_json['widget'].has_key?('id').must_equal true
        assert last_response_json['widget'].has_key?('name').must_equal true
        assert last_response_json['widget'].has_key?('supplier').must_equal true
        assert last_response_json['widget'].has_key?('cost').must_equal true




    end



end


