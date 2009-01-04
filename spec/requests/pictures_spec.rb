require File.join(File.dirname(__FILE__), '..', 'spec_helper.rb')

given "a picture exists" do
  Picture.all.destroy!
  request(resource(:pictures), :method => "POST", 
    :params => { :picture => { :id => nil }})
end

describe "resource(:pictures)" do
  describe "GET" do
    
    before(:each) do
      @response = request(resource(:pictures))
    end
    
    it "responds successfully" do
      @response.should be_successful
    end

    it "contains a list of pictures" do
      pending
      @response.should have_xpath("//ul")
    end
    
  end
  
  describe "GET", :given => "a picture exists" do
    before(:each) do
      @response = request(resource(:pictures))
    end
    
    it "has a list of pictures" do
      pending
      @response.should have_xpath("//ul/li")
    end
  end
  
  describe "a successful POST" do
    before(:each) do
      Picture.all.destroy!
      @response = request(resource(:pictures), :method => "POST", 
        :params => { :picture => { :id => nil }})
    end
    
    it "redirects to resource(:pictures)" do
      @response.should redirect_to(resource(Picture.first), :message => {:notice => "picture was successfully created"})
    end
    
  end
end

describe "resource(@picture)" do 
  describe "a successful DELETE", :given => "a picture exists" do
     before(:each) do
       @response = request(resource(Picture.first), :method => "DELETE")
     end

     it "should redirect to the index action" do
       @response.should redirect_to(resource(:pictures))
     end

   end
end

describe "resource(:pictures, :new)" do
  before(:each) do
    @response = request(resource(:pictures, :new))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@picture, :edit)", :given => "a picture exists" do
  before(:each) do
    @response = request(resource(Picture.first, :edit))
  end
  
  it "responds successfully" do
    @response.should be_successful
  end
end

describe "resource(@picture)", :given => "a picture exists" do
  
  describe "GET" do
    before(:each) do
      @response = request(resource(Picture.first))
    end
  
    it "responds successfully" do
      @response.should be_successful
    end
  end
  
  describe "PUT" do
    before(:each) do
      @picture = Picture.first
      @response = request(resource(@picture), :method => "PUT", 
        :params => { :picture => {:id => @picture.id} })
    end
  
    it "redirect to the article show action" do
      @response.should redirect_to(resource(@picture))
    end
  end
  
end

