# $Id$

require File.join(File.dirname(__FILE__), %w[spec_helper])

class TestView
  include ActionView::Helpers::DateHelper
end

test_view = TestView.new

describe Ciuchcia do
  it "should correctly tralnlate numbers to words" do
    number_in_words(1).should eql("jeden")
    number_in_words(1000).should eql("tysiąc")
    number_in_words(123).should eql("sto dwadzieścia trzy")
    number_in_words(1047).should eql("tysiąc czterdzieści siedem")
    number_in_words(12).should eql("dwanaście")
    number_in_words(666).should eql("sześćset sześćdziesiąt sześć")
    number_in_words(123456789).should eql("sto dwadzieścia trzy miliony czterysta pięćdziesiąt sześć tysięcy siedemset osiemdziesiąt dziewięć")
  end
  
  it "should know how to count mouney" do
    money_in_words(13.45).should eql("trzynaście złotych czterdzieści pięć groszy")
    money_in_words(2.30).should eql("dwa złote trzydzieści groszy")
    money_in_words(2401).should eql("dwa tysiące czterysta jeden złotych")
  end
  
  it "should tell distance in time po kurwa polsku" do
    test_view.distance_of_time_in_words(Time.now - 60,Time.now).should eql("1 minuta")
    test_view.distance_of_time_in_words(Time.now - 3600*2,Time.now).should eql("około 2 godziny")
  end
  
  it "should correctly validates NIP number" do
    Ciuchcia::Validations.valid_nip?('779-21-25-257').should be_true
    Ciuchcia::Validations.valid_nip?('779-21-25-254').should be_false
    Ciuchcia::Validations.valid_nip?('blablabla').should be_false
    Ciuchcia::Validations.valid_nip?('779-21-25-25423').should be_false
    Ciuchcia::Validations.valid_nip?('7792125223').should be_false
    Ciuchcia::Validations.valid_nip?('525-21-85-036').should be_true
  end

  it "should correctly validates REGON number" do
    Ciuchcia::Validations.valid_regon?('016385358').should be_true
    Ciuchcia::Validations.valid_regon?('016385354').should be_false
  end

  it "should correctly validates PESEL number" do
    Ciuchcia::Validations.valid_pesel?('85120701576').should be_true
    Ciuchcia::Validations.valid_pesel?('85120701575').should be_false
    Ciuchcia::Validations.valid_pesel?('82904310630').should be_false
  end
  
  it "shold have list of vulgar words" do
    Ciuchcia::Profanity.bad_word?('pizda').should be_true
  end
  
  it "should correctly check profanity" do
    Ciuchcia::Profanity.check(' ja kurwa eo').should eql('kurwa')
    Ciuchcia::Profanity.check('pierdole skurwysynów').should_not be_false
    Ciuchcia::Profanity.check('k u R w_a').should_not be_false
    Ciuchcia::Profanity.check('co za piiiizzz_da').should_not be_false
  end

  it "should correctly check profanity for utf-8 words" do
    Ciuchcia::Profanity.check('nie ma co pierdolić').should_not be_false
    Ciuchcia::Profanity.check('przypierdolić pizdą').should_not be_false
    Ciuchcia::Profanity.check('pierdolić').should_not be_false
  end

  it "should correctly check no profanity" do
    Ciuchcia::Profanity.check(' wiele kur warszawa ma').should be_false
    Ciuchcia::Profanity.check('kur.warszawa').should be_false    
  end
  
  it "should correctly check profanity no with no polish letters" do
    Ciuchcia::Profanity.check('pierdolic').should_not be_false
    Ciuchcia::Profanity.check('zapierdolic').should_not be_false    
    Ciuchcia::Profanity.check('pierdol0ny').should_not be_false    
  end
  
end

describe ActiveRecord::Base do
  it "should respond to validations" do
    ActiveRecord::Base.should respond_to(:validates_regon)
    ActiveRecord::Base.should respond_to(:validates_nip)
    ActiveRecord::Base.should respond_to(:validates_pesel)
    ActiveRecord::Base.should respond_to(:validates_no_profanity)
  end
end

