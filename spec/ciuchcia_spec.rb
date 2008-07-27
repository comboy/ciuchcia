# $Id$

require File.join(File.dirname(__FILE__), %w[spec_helper])

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
  
  it "should correctly validates NIP number" do
    Ciuchcia::Validations.valid_nip?('779-21-25-257').should == true
    Ciuchcia::Validations.valid_nip?('779-21-25-254').should == false
    Ciuchcia::Validations.valid_nip?('blablabla').should == false
    Ciuchcia::Validations.valid_nip?('779-21-25-25423').should == false
    Ciuchcia::Validations.valid_nip?('7792125223').should == false
    Ciuchcia::Validations.valid_nip?('525-21-85-036').should == true
  end

  it "should correctly validates REGON number" do
    Ciuchcia::Validations.valid_regon?('016385358').should == true
    Ciuchcia::Validations.valid_regon?('016385354').should == false
  end

  it "should correctly validates PESEL number" do
    Ciuchcia::Validations.valid_pesel?('85120701576').should == true
    Ciuchcia::Validations.valid_pesel?('85120701575').should == false
    Ciuchcia::Validations.valid_pesel?('82904310630').should == false
  end
  
  
end

describe ActiveRecord::Base do
  it "should respond to validations" do
    ActiveRecord::Base.should respond_to :validates_regon
    ActiveRecord::Base.should respond_to :validates_nip
    ActiveRecord::Base.should respond_to :validates_pesel
  end
end

