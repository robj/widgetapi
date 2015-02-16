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


    it "should create a new widget" do


        widget = { name: 'widgee', supplier: 'widgsoft', cost: 32 }

        post '/api/widgets', {widget: widget}
        assert last_response.successful?
        assert last_response_json['widget']['name'].must_equal 'widgee'



    end



    it "should get and update a widget" do


        widget = FactoryGirl.create(:widget)

        get '/api/widgets'
        assert last_response.successful?
        widget_json =  last_response_json['widgets'].first

        widget_id = widget_json['id']
        widget_json['supplier'] = 'supplierX'

        put "/api/widgets/#{widget_id}", {widget: widget_json}
        assert last_response.successful?
        assert last_response_json['widget']['supplier'].must_equal 'supplierX'


    end



    it "should get and update a widget, ensuring strong_params prevents name being updated" do


        widget = FactoryGirl.create(:widget)

        get '/api/widgets'
        assert last_response.successful?
        widget_json =  last_response_json['widgets'].first

        widget_id = widget_json['id']
        widget_original_name =  widget_json['name'] 
       
        widget_json['name'] = 'nameX'
        put "/api/widgets/#{widget_id}", {widget: widget_json}

        assert last_response.successful?
        assert last_response_json['widget']['name'].must_equal widget_original_name


    end
  

    it "should get and delete a widget if authorized" do


        auth_token = 's3cr3t'
        widget = FactoryGirl.create(:widget)

        get '/api/widgets'
        assert last_response.successful?
        widget_json =  last_response_json['widgets'].first
        widget_id = widget_json['id']

        delete "/api/widgets/#{widget_id}", {auth_token: 'incorrect'}
        assert last_response.client_error?
        assert last_response.status.must_equal 401 #unauthorized
 
        delete "/api/widgets/#{widget_id}", {auth_token: auth_token}
        assert last_response.successful?
        assert last_response.status.must_equal 204 #no_content


    end




end


